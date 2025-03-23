import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/math_constructions/index.dart';
import 'parsers/deleteting_parser.dart';
import 'parsers/formula_to_tex_parser.dart';
import 'parsers/formulas_tree_parsers.dart';
import 'services/math_constructions_building.dart';
import 'services/text_field_handle_and_create.dart';
import 'services/widgets_data_handler.dart';

const _timeToUpdateFormula = Duration(seconds: 1);
const _timeToRebuildScreen = Duration(milliseconds: 50);

class MathController extends ChangeNotifier{
  late final TextFieldHandleAndCreateService _textFieldService; 
  late final MathConstructionsBuilding _mathConstructionsBuildingService; 
  late final FormulasTreeParsersService _parsersService; 
  late final WidgetsDataHandler _dataHandler; 
  late final FormulaToTexParser _texParsingService; 
  late final FormulasTreeDeletingParser _deletingParserService;
  
  final _streamController = StreamController<String>.broadcast();
  Stream<String> get katexFormulaStream => _streamController.stream;

  final _renderController = StreamController<void>.broadcast();

  bool isFormulaUpdated = true; 
  bool _isFormulaRendred = true; 
  bool get isFormulaRendred => _isFormulaRendred;

  MathController(){
    _textFieldService = TextFieldHandleAndCreateService();
    _mathConstructionsBuildingService = MathConstructionsBuilding(textFieldService: _textFieldService);
    _parsersService = FormulasTreeParsersService();
    _dataHandler = WidgetsDataHandler(); 
    _texParsingService = FormulaToTexParser();
    _deletingParserService = FormulasTreeDeletingParser(); 
    _initialization();
  }
  final List<Widget> _formulaGroopWidgets = [];

  List<Widget> getFormulaWidgets(){
    return _formulaGroopWidgets.toList(); 
  }

  void _initialization(){
    final defaultTextField = _mathConstructionsBuildingService.initialization(); 
    _formulaGroopWidgets.add(defaultTextField); 
    _setupStreams();
  }
  
  void _setupStreams() { 
    Timer? timer;
    _streamController.onListen = () { 
      timer = Timer.periodic(_timeToUpdateFormula, (timer) {
        if (_isFormulaRendred) {
          _streamController.add(_requestFormulaToKaTeXParse());
        }
      });
    };
    _streamController.onCancel = () {
      timer?.cancel();
    };

    _renderController.stream.listen(
      (isRendred) {
        _isFormulaRendred = !_isFormulaRendred;
      }
    );
  }

  void addCharToTextField(String char){
    _textFieldService.addCharToTextField(char);
  }

  String _requestFormulaToKaTeXParse() {
      return _texParsingService.start(_formulaGroopWidgets);
  }

  FutureOr<String> getFormulaKaTeX() {
    if(_isFormulaRendred){
      return _texParsingService.start(_formulaGroopWidgets);
    }else{
      return Future.value(_renderController.stream.first)
        .then((_) => _texParsingService.start(_formulaGroopWidgets));
    }
  }

  void onFracButtonTap(){
    final parsedWidgets = _parsersService.parseWidgetLocation(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    if(parsedWidgets != null){
      final fracWidget = _mathConstructionsBuildingService.createFracWidget();
      _dataHandler.replaceWidgetInTree(parsedWidgets, fracWidget);
      rebuildSreenState();
    }
  }

  void namedFunctionButtonTap(String functionName, ElementsType type){
    final parsedWidgets = _parsersService.parseWidgetLocation(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    if(parsedWidgets != null){
      final namedWidget = _mathConstructionsBuildingService.createNamedFunctionWidget(functionName, type); 
      _dataHandler.replaceWidgetInTree(parsedWidgets, namedWidget); 
      rebuildSreenState(); 
    }
  }

  void onExpButtonTap(){
    final activeTextFieldController = _textFieldService.getActiveTextFieldController();
    final parsedWidgets = _parsersService.parseWidgetLocation(_formulaGroopWidgets, activeTextFieldController); 
    TextFieldData baseField; 
    if(activeTextFieldController.text.isNotEmpty){
      baseField = _textFieldService.getActiveTextFieldData();
    }
    else{
      if(parsedWidgets?.index != null && parsedWidgets!.index! >= 1){
        parsedWidgets.index = parsedWidgets.index! - 1;
        baseField = _textFieldService.getPreviousTextFieldDataToActive();
      }else{
        baseField = _textFieldService.getActiveTextFieldData();  
      }
    }
    if(parsedWidgets != null && parsedWidgets.index != null){
      final baseWidget = parsedWidgets.wigetData![parsedWidgets.index!];
      final expWidget = _mathConstructionsBuildingService.createExpWidget(baseWidget, baseField);
      _dataHandler.replaceWidgetInTree(parsedWidgets, expWidget);
      rebuildSreenState();
    }
  }

  void sqrtButtonTap(){
    final parsedWidgets = _parsersService.parseWidgetLocation(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    if(parsedWidgets != null){
      final sqrtWidget = _mathConstructionsBuildingService.createSqrtWidget(); 
      _dataHandler.replaceWidgetInTree(parsedWidgets, sqrtWidget);
      rebuildSreenState();
    }
  }

  void logButtonTap(){
    final activeTextFieldController = _textFieldService.getActiveTextFieldController();
    final parsedWidgets = _parsersService.parseWidgetLocation(_formulaGroopWidgets, activeTextFieldController);
    if(parsedWidgets != null){
      final logWidget = _mathConstructionsBuildingService.createLogWidget(); 
      _dataHandler.replaceWidgetInTree(parsedWidgets, logWidget);
      rebuildSreenState(); 
    }
  }

  void limButtonTap(){
    final parsedWidgetData = _parsersService.parseWidgetLocation(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    if(parsedWidgetData != null){
      final limitWidget = _mathConstructionsBuildingService.createLimitWidget(); 
      _dataHandler.replaceWidgetInTree(parsedWidgetData, limitWidget);
      rebuildSreenState(); 
    }
  } 

  void absButtonTap(){
    final parsedWidgetData = _parsersService.parseWidgetLocation(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    if(parsedWidgetData != null){
      final absWidet = _mathConstructionsBuildingService.createAbsWidget();
      _dataHandler.replaceWidgetInTree(parsedWidgetData, absWidet);
      rebuildSreenState(); 
    }
  }

  void backetsButtonTap(){
    final parsedWidgetData = _parsersService.parseWidgetLocation(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    if(parsedWidgetData != null){
      final backetsWidget = _mathConstructionsBuildingService.createBracketsWidget();
      _dataHandler.replaceWidgetInTree(parsedWidgetData, backetsWidget);
      rebuildSreenState(); 
    }
  }

  void undefinitintegralButtonTap(){
    final parsedWidgetData = _parsersService.parseWidgetLocation(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    if(parsedWidgetData != null){
      final integralWidget = _mathConstructionsBuildingService.createUndefinitIntegralWidget();
      _dataHandler.replaceWidgetInTree(parsedWidgetData, integralWidget);
      rebuildSreenState(); 
    }
  }

  void integralButtonTap(){
    final parsedWidgetData = _parsersService.parseWidgetLocation(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController() );
    if(parsedWidgetData!= null){
      final integralWidget = _mathConstructionsBuildingService.createIntegralWidget();
      _dataHandler.replaceWidgetInTree(parsedWidgetData, integralWidget);
      rebuildSreenState();
    }
  }
  void onDerevativeButtonTap({String? upperField, String? downField}){
    final parsedWidgetData = _parsersService.parseWidgetLocation(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController() );
    if(parsedWidgetData!= null){
      final derevativeWidget = _mathConstructionsBuildingService.createDerevativeWidget(upperField,downField);
      _dataHandler.replaceWidgetInTree(parsedWidgetData, derevativeWidget);
      rebuildSreenState();
    }
  }

  void selectNextFocus(){
    final shouldNotCreateNewField = _textFieldService.trySelectNextFocus();
    if(!shouldNotCreateNewField){
      final parsedWidgetData = _parsersService.parseWidgetContainerLocation(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
        if(parsedWidgetData != null){
          final textFieldConstruction = _mathConstructionsBuildingService.createTextField(replaceOldFocus: true);
          _dataHandler.addToWidgetTree(parsedWidgetData, [textFieldConstruction.construction]); 
          rebuildSreenState();
        }
    } 
  }

  void createCharWidgets(String char){
    final activeTextFieldController = _textFieldService.getActiveTextFieldController();
    final parsedWidgetData = _parsersService.parseWidgetLocation(_formulaGroopWidgets, activeTextFieldController);
    if(parsedWidgetData == null) return;
    final List<Widget> textFields = [];
    if(_textFieldService.getActiveTextFieldController().text.isEmpty){
      _textFieldService.getActiveTextFieldController().text = char; 
    }else{
      textFields.add(_mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
      _textFieldService.getActiveTextFieldController().text = char; 
    }
    final addictionalField = _mathConstructionsBuildingService.createCharWidget(isActiveTextField: true);
    textFields.add(addictionalField);
    _dataHandler.addToWidgetTree(parsedWidgetData, textFields);
    rebuildSreenState();
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
      _formulaGroopWidgets, 
      activeController
    );
    
    if (parsedWidgets == null) {
      return;
    }

    final fieldsCountInElement = _getFieldsCountInElement(parsedWidgets, activeController);
    
    if (fieldsCountInElement == null) {
      _replaceElementByField(activeController);
      rebuildSreenState();
      return;
    }

    if (fieldsCountInElement.fieldsCount > 1) {
      _deleteFieldOrGroup(parsedWidgets, fieldsCountInElement.ourFieldLocation == 1);
    } else {
      _replaceElementByField(activeController);
    }

    rebuildSreenState();
  }

  ElementFieldsData? _getFieldsCountInElement(ParsedWidgetsData parsedWidgets, TextEditingController activeController) {
    return _deletingParserService.getCountOfTextFieldsIn(
      parsedWidgets.wigetData!, 
      activeController
    );
  }

  void _deleteFieldOrGroup(ParsedWidgetsData parsedWidgets, bool shouldRemarkGroup) {
    final isSuccess = _textFieldService.deleteCurrentController(shouldRemarkGroup);
    
    if (isSuccess) {
      _dataHandler.deleteFromWidgetTree(parsedWidgets);
    } else {
      deleteAllButtonTap();
    }
  }

  void _replaceElementByField(TextEditingController activeController) {
    final elementToReplace = _deletingParserService.getElement(
      _formulaGroopWidgets, 
      activeController
    );

    if (!_tryDeleteControllers(elementToReplace?.isGroop)) {
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
    return _textFieldService.deleteElementFields(isGroup);
  }

  void _replaceWithNewField(ParsedWidgetsData elementToReplace, bool moveToFirst) {
    final newField = _mathConstructionsBuildingService.createTextField(
      replaceOldFocus: false,
      format: TextFieldFormat.standart
    );
    if(moveToFirst) {
      final textFieldData = ((newField.construction as SizedBox).child as TextFieldWidgetHandler).textFieldData;
      _textFieldService.intertThisFieldToStart(textFieldData);
    }
    _dataHandler.replaceWidgetInTree(elementToReplace, newField);
  }

  void _removeCurrentField(TextEditingController activeController) {
    final dataToReplaceField = _parsersService.parseWidgetLocation(
      _formulaGroopWidgets,
      activeController
    );
    
    if (dataToReplaceField != null) {
      _dataHandler.deleteFromWidgetTree(dataToReplaceField);
    }
  }

  void deleteAllButtonTap() {
    _formulaGroopWidgets.clear();
    _textFieldService.deleteAllTextFields();
    _initialization();
    notifyListeners();
  }

  void rebuildSreenState() {
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