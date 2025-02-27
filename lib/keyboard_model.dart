import 'package:flutter/material.dart';
import 'package:math_keyboard/parsers/deleteting_parser.dart';
import 'package:math_keyboard/parsers/formula_to_tex_parser.dart';
import 'package:math_keyboard/parsers/formulas_tree_parsers_and_handler.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';
import 'package:math_keyboard/services/widgets_data_handler.dart';

class KeyboardModel extends ChangeNotifier{
  late final TextFieldHandleAndCreateService _textFieldService; 
  late final MathConstructionsBuilding _mathConstructionsBuildingService; 
  late final FormulasTreeParsersService _parsersService; 
  late final WidgetsDataHandler _dataHandler; 
  late final FormulaToTexParser _texParsingService; 
  late final FormulasTreeDeletingParser _deletingParserService;

  bool update = true; 
  String? formulaInTeX; 

  KeyboardModel(){
    _textFieldService = TextFieldHandleAndCreateService();
    _mathConstructionsBuildingService = MathConstructionsBuilding(textFieldService: _textFieldService);
    _parsersService = FormulasTreeParsersService();
    _dataHandler = WidgetsDataHandler(); 
    _texParsingService = FormulaToTexParser();
    _deletingParserService = FormulasTreeDeletingParser(); 
    initialization();
  }
  final List<Widget> _formulaGroopWidgets = [];

  List<Widget> getFormulaWidgets(){
    return _formulaGroopWidgets.toList(); 
  }

  void initialization(){
    final defaultTextField = _mathConstructionsBuildingService.initialization(); 
    _formulaGroopWidgets.add(defaultTextField); 
    // notifyListeners();
  }

  void addCharToTextField(String char){
    _textFieldService.addCharToTextField(char);
  }

  String getFormulaKaTeX() {
    return _texParsingService.start(_formulaGroopWidgets);
  }

  void onFracButtonTap(){
    final parsedWidgets = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    final fracWidget = _mathConstructionsBuildingService.createFracWidget();
    if(parsedWidgets != null){
      _dataHandler.replaceWidgetInTree(parsedWidgets, fracWidget);
      rebuildSreenState();
    }
  }

  void namedFunctionButtonTap(String functionName, ElementsType type){
    final parsedWidgets = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    final fracWidget = _mathConstructionsBuildingService.createNamedFunctionWidget(functionName, type); 
    if(parsedWidgets != null){
      _dataHandler.replaceWidgetInTree(parsedWidgets, fracWidget); 
      rebuildSreenState(); 
    }
  }

  void onExpButtonTap(){
    ReturnData? parsedWidgets;  
    final activeTextFieldController = _textFieldService.getActiveTextFieldController();
    late final TextFieldData baseField; 
    if(activeTextFieldController.text.isNotEmpty){
      parsedWidgets = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, activeTextFieldController); 
      baseField = _textFieldService.getActiveTextFieldData();
    }
    else{
      parsedWidgets = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, activeTextFieldController);
      if(parsedWidgets?.index != null && parsedWidgets!.index! >= 1){
        parsedWidgets.index = parsedWidgets.index! - 1;
        baseField = _textFieldService.getPreviousTextFieldDataToActive();
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
    final parsedWidgets = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    final sqrtWidget = _mathConstructionsBuildingService.createSqrtWidget(); 
    if(parsedWidgets != null){
      _dataHandler.replaceWidgetInTree(parsedWidgets, sqrtWidget);
      rebuildSreenState();
    }
  }

  void logButtonTap(){
    final activeTextFieldController = _textFieldService.getActiveTextFieldController();
    final parsedWidgets = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, activeTextFieldController);
    final logWidget = _mathConstructionsBuildingService.createLogWidget(); 
    if(parsedWidgets != null){
      _dataHandler.replaceWidgetInTree(parsedWidgets, logWidget);
      rebuildSreenState(); 
    }
  }

  void limButtonTap(){
    final parsedWidgetData = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    final limitWidget = _mathConstructionsBuildingService.createLimitWidget(); 
    if(parsedWidgetData != null){
      _dataHandler.replaceWidgetInTree(parsedWidgetData, limitWidget);
      rebuildSreenState(); 
    }
  }

  void absButtonTap(){
    final parsedWidgetData = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    final absWidet = _mathConstructionsBuildingService.createAbsWidget();
    if(parsedWidgetData != null){
      _dataHandler.replaceWidgetInTree(parsedWidgetData, absWidet);
      rebuildSreenState(); 
    }
  }

  void backetsButtonTap(){
    final parsedWidgetData = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    final backetsWidget = _mathConstructionsBuildingService.createBracketsWidget();
    if(parsedWidgetData != null){
      _dataHandler.replaceWidgetInTree(parsedWidgetData, backetsWidget);
      rebuildSreenState(); 
    }
  }

  void undefinitintegralButtonTap(){
    final parsedWidgetData = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
    final integralWidget = _mathConstructionsBuildingService.createUndefinitIntegralWidget();
    if(parsedWidgetData != null){
      _dataHandler.replaceWidgetInTree(parsedWidgetData, integralWidget);
      rebuildSreenState(); 
    }
  }

  void integralButtonTap(){
    final parsedWidgetData = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController() );
    final integralWidget = _mathConstructionsBuildingService.createIntegralWidget();
    if(parsedWidgetData!= null){
      _dataHandler.replaceWidgetInTree(parsedWidgetData, integralWidget);
      rebuildSreenState();
    }
  }
  void onDerevativeButtonTap({String? upperField, String? downField}){
    final parsedWidgetData = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController() );
    final derevativeWidget = _mathConstructionsBuildingService.createDerevativeWidget(upperField,downField);
    if(parsedWidgetData!= null){
      _dataHandler.replaceWidgetInTree(parsedWidgetData, derevativeWidget);
      rebuildSreenState();
    }
  }

  void selectNextFocus(){
    final shouldNotCreateNewField = _textFieldService.trySelectNextFocus();
    if(!shouldNotCreateNewField){
      final parsedWidgetData = _parsersService.parseWidgetList(_formulaGroopWidgets, _textFieldService.getActiveTextFieldController());
      final textFieldConstruction = _mathConstructionsBuildingService.createTextField(replaceOldFocus: true);
        if(parsedWidgetData != null){
          _dataHandler.addToWidgetTree(parsedWidgetData, [textFieldConstruction.construction]); 
          rebuildSreenState();
        }
    } 
  }

  void createCharWidgets(String char){
    // один сплошной костыль 
    final activeTextFieldController = _textFieldService.getActiveTextFieldController();
    final parsedWidgetData = _parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, activeTextFieldController);
    List<Widget> textField=[];
    if(_textFieldService.getActiveTextFieldController().text.isEmpty){
      _textFieldService.getActiveTextFieldController().text = char; 
      textField.add(_mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
    }else{
      textField.add(_mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
      _textFieldService.getActiveTextFieldController().text = char; 
      textField.add(_mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
    }
    if (parsedWidgetData != null) {
      _dataHandler.addToWidgetTree(parsedWidgetData, textField);
      rebuildSreenState();
    }
    
  }

  void selectBackFocus(){
    _textFieldService.selectBackFocus(); 
  }

  void backspaceButtonTap() {
    final activeController = _textFieldService.getActiveTextFieldController();
    if (activeController.text.isNotEmpty) {
      _textFieldService.deleteLastChar();
    } else {
      CountData? fieldsInElementCountData;
      final parsedWidgets = _parsersService.parseWidgetListWithReplacment(
        _formulaGroopWidgets, 
        activeController
      );
      if (parsedWidgets != null) {
        fieldsInElementCountData = _deletingParserService.
            getCountOfTextFieldsIn(parsedWidgets.wigetData!, activeController);
      }
      if (fieldsInElementCountData != null && fieldsInElementCountData.count > 1) {
        final shouldRemarkGroop = fieldsInElementCountData.fieldLocation == 1; 
        _deleteField(parsedWidgets!, shouldRemarkGroop);
      } else {
        _replaceElementByFiled(activeController);
      }
      rebuildSreenState(hard: true);
    }
  }

  void _deleteField(ReturnData parsedWidgets, bool shouldRemarkGroop) {
    final isSuccess =
        _textFieldService.deleteCurrentController(shouldRemarkGroop);
    if (isSuccess) {
      _dataHandler.deleteFromWidgetTree(parsedWidgets);
    } else {
      deleteAllButtonTap();
    }
  } 

  void _replaceElementByFiled(TextEditingController activeController) { 
    final elementToReplace = _deletingParserService.parseWidgetList(
      _formulaGroopWidgets, 
      activeController
    );
    final isControllersDeleted =
        _textFieldService.deleteElementFields(elementToReplace?.isGroop);
    if (!isControllersDeleted) {
      deleteAllButtonTap();
      return; 
    }

    if (elementToReplace != null) {
      final newField = _mathConstructionsBuildingService.createTextField(
        replaceOldFocus: false, 
        standartSize: true
      );
      _dataHandler.replaceWidgetInTree(elementToReplace, newField);
    } else {
      final dataToReplaceField = _parsersService.parseWidgetListWithReplacment(
        _formulaGroopWidgets,
        activeController
      );
      if (dataToReplaceField != null) {
        _dataHandler.deleteFromWidgetTree(dataToReplaceField);
      }
    }
  }

  void deleteAllButtonTap(){
    _formulaGroopWidgets.clear();
    _textFieldService.deleteAllTextFields(); 
    initialization(); 
    notifyListeners();
  }

  void rebuildSreenState({bool hard = false}){
    update = false; 
    notifyListeners();
    Future.delayed(
      !hard ? const Duration(milliseconds: 50) : const Duration(milliseconds: 50),
      (){
        update = true; 
        notifyListeners();
        _textFieldService.requestFocusToActiveTextField();
      }
    );
  }
}