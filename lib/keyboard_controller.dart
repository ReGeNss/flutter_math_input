import 'dart:async';
import 'package:flutter/material.dart';
import 'math_constructions/math_construction.dart';
import 'parsers/deleting_parser.dart';
import 'parsers/formula_to_tex_parser.dart';
import 'parsers/formulas_tree_parsers.dart';
import 'services/math_constructions_building.dart';
import 'services/text_field_handle_and_create.dart';
import 'services/widgets_data_handler.dart';

const _timeToUpdateFormula = Duration(seconds: 1);
const _timeToRebuildScreen = Duration(milliseconds: 50);

class MathController extends ChangeNotifier{
  final _textFieldService  = TextFieldHandleAndCreateService(); 
  late final _mathConstructionsBuildingService = MathConstructionsBuilding(
    textFieldService: _textFieldService,
  );  
  final _parsersService = FormulasTreeParsersService(); 
  final _dataHandler = WidgetsDataHandler(); 
  final _texParsingService = FormulaToTexParser();  
  final _deletingParserService = FormulasTreeDeletingParser();
  
  final List<Widget> _formulaGroupWidgets = [];

  final _streamController = StreamController<String>.broadcast();
  final _renderController = StreamController<void>.broadcast();

  bool isFormulaUpdated = true; 
  bool _isFormulaRendered = true; 

  Stream<String> get katexFormulaStream => _streamController.stream;
  bool get isFormulaRendered => _isFormulaRendered;

  MathController(){
    _initialization();
  }

  List<Widget> getFormulaWidgets() => _formulaGroupWidgets.toList(); 

  void _initialization(){
    final defaultTextField = _mathConstructionsBuildingService.initialization();
    _formulaGroupWidgets.add(defaultTextField); 
    _setupStreams();
  }
  
  void _setupStreams() { 
    Timer? timer;
    _streamController.onListen = () { 
      timer = Timer.periodic(_timeToUpdateFormula, (_) {
        if (!_isFormulaRendered) return;
        _streamController.add(_requestFormulaToKaTeXParse());
      });
    };
    _streamController.onCancel = () {
      timer?.cancel();
    };

    _renderController.stream.listen(
      (_) {
        _isFormulaRendered = !_isFormulaRendered;
      }
    );
  }

  void addCharToTextField(String char){
    _textFieldService.addCharToTextField(char);
  }

  String _requestFormulaToKaTeXParse() {
      return _texParsingService.start(_formulaGroupWidgets);
  }

  FutureOr<String> getFormulaKaTeX() {
    return _isFormulaRendered 
    ? _texParsingService.start(_formulaGroupWidgets) 
    : Future.value(_renderController.stream.first).
      then((_) => _texParsingService.start(_formulaGroupWidgets));
  }

  void createDefaultFunc(
    DefaultMathConstruction Function(MathConstructionsBuilding) constructionFactory,
  ){
    final construction = constructionFactory(_mathConstructionsBuildingService);
    final parsedWidgets = _parsersService.parseWidgetLocation(
      _formulaGroupWidgets, 
      _textFieldService.getActiveTextFieldController(),
    );
    if(parsedWidgets == null) return;
    final constructionWidget = construction.createConstruction(); 
    _dataHandler.replaceWidgetInTree(parsedWidgets, constructionWidget);
    rebuildScreenState();
  }

  void createComplicatedFunc(
    ComplicatedMathConstruction Function(
      MathConstructionsBuilding, {
      required TextFieldHandleAndCreateService textFieldService,
      required ParsedWidgetsData parsingResults,
      required List<Widget> widgetTree,
    }) constructionFactory,
  ){
    final parsedWidgets = _parsersService.parseWidgetLocation(
      _formulaGroupWidgets, 
      _textFieldService.getActiveTextFieldController(),
    );
    if(parsedWidgets == null || parsedWidgets.index == null) return;
    final construction = constructionFactory(
      _mathConstructionsBuildingService,
      textFieldService: _textFieldService,
      parsingResults: parsedWidgets,
      widgetTree: _formulaGroupWidgets,
    );
    final constructionWidget = construction.createConstruction(); 
    _dataHandler.replaceWidgetInTree(parsedWidgets, constructionWidget);
    rebuildScreenState();
  }

  void selectNextFocus(){
    final shouldNotCreateNewField = _textFieldService.trySelectNextFocus();
    if(!shouldNotCreateNewField){
      final parsedWidgetData = _parsersService.parseWidgetContainerLocation(
        _formulaGroupWidgets, 
        _textFieldService.getActiveTextFieldController(),
      );
      if(parsedWidgetData == null) return; 

      final textField = _mathConstructionsBuildingService.createTextField(
        replaceOldFocus: true, 
        isActive: true,
      );
      _dataHandler.addToWidgetTree(parsedWidgetData, [textField]); 
      rebuildScreenState();
    } 
  }

  void createCharWidgets(String char){
    final activeTextFieldController = 
      _textFieldService.getActiveTextFieldController();
    final parsedWidgetData = _parsersService.parseWidgetLocation(
      _formulaGroupWidgets, 
      activeTextFieldController,
    );
    if(parsedWidgetData == null) return;
    final List<Widget> textFields = [];
    if(_textFieldService.getActiveTextFieldController().text.isEmpty){
      _textFieldService.getActiveTextFieldController().text = char; 
    }else{
      textFields.add(_mathConstructionsBuildingService.createCharWidget(
        isActiveTextField: true,
        ),
      );
      _textFieldService.getActiveTextFieldController().text = char; 
    }
    final additionalField = _mathConstructionsBuildingService.createCharWidget(
      isActiveTextField: true,
    );
    textFields.add(additionalField);
    _dataHandler.addToWidgetTree(parsedWidgetData, textFields);
    rebuildScreenState();
  }

  void selectBackFocus(){
    _textFieldService.selectBackFocus(); 
  }

  void backspaceButtonTap() {
    final activeController = _textFieldService.getActiveTextFieldController();
    
    if (_canDeleteCharFromCurrentField(activeController)) {
      _textFieldService.deleteLastChar();
    } else { 
      _handleEmptyFieldDeletion(activeController);
    }
  }

  bool _canDeleteCharFromCurrentField(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }

  void _handleEmptyFieldDeletion(TextEditingController activeController) {
    final parsedWidgets = _parsersService.parseWidgetLocation(
      _formulaGroupWidgets, 
      activeController,
    );
    
    if (parsedWidgets == null) {
      return;
    }

    final fieldsCountInConstruction = _getFieldsCountInConstruction(
      parsedWidgets, 
      activeController,
    );
    
    if(fieldsCountInConstruction == null) {
      _replaceElementByField(activeController);
      rebuildScreenState();

      return;
    }

    if (fieldsCountInConstruction.fieldsCount > 1) {
      _deleteFieldOrGroup(
        parsedWidgets, 
        fieldsCountInConstruction.ourFieldLocation == 1,
      );
    } else {
      _replaceElementByField(activeController);
    }

    rebuildScreenState();
  }

  ElementFieldsData? _getFieldsCountInConstruction(
    ParsedWidgetsData parsedWidgets, 
    TextEditingController activeController,
  ) {
    return _deletingParserService.getCountOfTextFieldsIn(
      parsedWidgets.widgetData!, 
      activeController,
    );
  }

  void _deleteFieldOrGroup(
    ParsedWidgetsData parsedWidgets, 
    bool shouldRemarkGroup,
  ) {
    final isSuccess = _textFieldService.deleteCurrentController(
      shouldRemarkGroup:  shouldRemarkGroup,
    );
    
    if (isSuccess) {
      _dataHandler.deleteFromWidgetTree(parsedWidgets);
    } else {
      deleteAllButtonTap();
    }
  }

  void _replaceElementByField(TextEditingController activeController) {
    final elementToReplace = _deletingParserService.getElement(
      _formulaGroupWidgets, 
      activeController,
    );

    if (!_tryDeleteControllers(elementToReplace?.isGroup)) {
      deleteAllButtonTap();

      return;
    }

    if (elementToReplace != null) {
      final shouldMoveToFirst = elementToReplace.index == 0;
      _replaceWithNewField(elementToReplace, shouldMoveToFirst);
    } else {
      _removeCurrentField(activeController);
    }
  }

  bool _tryDeleteControllers(bool? isGroup) {
    return _textFieldService.deleteElementFields(checkGroups: isGroup);
  }

  void _replaceWithNewField(
    ParsedWidgetsData elementToReplace, 
    bool moveToFirst,
  ) {
    final newField = _mathConstructionsBuildingService.createTextField(
      isActive: true,
      format: TextFieldFormat.standard,
    );
    if(moveToFirst) {
      final textFieldData = (
        (newField as SizedBox).child! as TextFieldWidgetHandler
      ).textFieldData;
      _textFieldService.insertThisFieldToStart(textFieldData);
    }
    _dataHandler.replaceWidgetInTree(
      elementToReplace,
      MathConstructionWidgetData(construction: newField),
    );
  }

  void _removeCurrentField(TextEditingController activeController) {
    final dataToReplaceField = _parsersService.parseWidgetLocation(
      _formulaGroupWidgets,
      activeController,
    );
    
    if (dataToReplaceField != null) {
      _dataHandler.deleteFromWidgetTree(dataToReplaceField);
    }
  }

  void deleteAllButtonTap() {
    _formulaGroupWidgets.clear();
    _textFieldService.deleteAllTextFields();
    _initialization();
    notifyListeners();
  }

  void rebuildScreenState() {
    isFormulaUpdated = false;
    changeFormulaRenderingState();
    notifyListeners();
        
    Future.delayed(_timeToRebuildScreen, () {
      isFormulaUpdated = true;
      notifyListeners();
      _textFieldService.requestFocusToActiveTextField();
    });
  }

  void changeFormulaRenderingState(){
    _renderController.add(null);
  }

  @override
  void dispose() {
    _streamController.close();
    _renderController.close(); 
    _textFieldService.dispose();
    super.dispose();
  }
}
