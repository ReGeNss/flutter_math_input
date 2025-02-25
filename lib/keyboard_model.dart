import 'package:flutter/material.dart';
import 'package:math_keyboard/parsers/deleteting_parser.dart';
import 'package:math_keyboard/parsers/formula_to_tex_parser.dart';
import 'package:math_keyboard/parsers/formulas_tree_parsers_and_handler.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';
import 'package:math_keyboard/services/widgets_data_handler.dart';

class KeyboardModel extends ChangeNotifier{
  late final TextFieldHandleAndCreateService textFieldService; 
  late final MathConstructionsBuilding mathConstructionsBuildingService; 
  late final FormulasTreeParsersService parsersService; 
  late final WidgetsDataHandler dataHandler; 
  late final FormulaToTexParser texParsingService; 
  late final FormulasTreeDeletingParser deletingParserService;

  bool update = true; 
  String? formulaInTeX; 

  KeyboardModel(){
    textFieldService = TextFieldHandleAndCreateService();
    mathConstructionsBuildingService = MathConstructionsBuilding(textFieldService: textFieldService);
    parsersService = FormulasTreeParsersService();
    dataHandler = WidgetsDataHandler(); 
    texParsingService = FormulaToTexParser();
    deletingParserService = FormulasTreeDeletingParser(); 
    initialization();
  }
  final List<Widget> _formulaGroopWidgets = [];

  List<Widget> getFormulaWidgets(){
    return _formulaGroopWidgets.toList(); 
  }

  void initialization(){
    final defaultTextField = mathConstructionsBuildingService.initialization(); 
    _formulaGroopWidgets.add(defaultTextField); 
    // notifyListeners();
  }
  void onFracButtonTap(){
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, textFieldService.getActiveTextFieldController());
    final fracWidget = mathConstructionsBuildingService.createFracWidget();
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, fracWidget);
      rebuildSreenState();
    }
  }

  void namedFunctionButtonTap(String functionName, ElementsType type){
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, textFieldService.getActiveTextFieldController());
    final fracWidget = mathConstructionsBuildingService.createNamedFunctionWidget(functionName, type); 
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, fracWidget); 
      rebuildSreenState(); 
    }
  }

  void onExpButtonTap(){
    ReturnData? parsedWidgets;  
    final activeTextFieldController = textFieldService.getActiveTextFieldController();
    late final TextFieldData baseField; 
    if(activeTextFieldController.text.isNotEmpty){
      parsedWidgets = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, activeTextFieldController); 
      baseField = textFieldService.getActiveTextFieldData();
    }
    else{
      parsedWidgets = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, activeTextFieldController);
      if(parsedWidgets?.index != null && parsedWidgets!.index! >= 1){
        parsedWidgets.index = parsedWidgets.index! - 1;
        baseField = textFieldService.getPreviousTextFieldDataToActive();
      }
    }
    if(parsedWidgets != null && parsedWidgets.index != null){
      final baseWidget = parsedWidgets.wigetData![parsedWidgets.index!];
      final expWidget = mathConstructionsBuildingService.createExpWidget(baseWidget, baseField);
      dataHandler.replaceWidgetInTree(parsedWidgets, expWidget);
      rebuildSreenState();
    }
  }

  void sqrtButtonTap(){
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, textFieldService.getActiveTextFieldController());
    final sqrtWidget = mathConstructionsBuildingService.createSqrtWidget(); 
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, sqrtWidget);
      rebuildSreenState();
    }
  }

  void logButtonTap(){
    final activeTextFieldController = textFieldService.getActiveTextFieldController();
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, activeTextFieldController);
    final logWidget = mathConstructionsBuildingService.createLogWidget(); 
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, logWidget);
      rebuildSreenState(); 
    }
  }

  void limButtonTap(){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, textFieldService.getActiveTextFieldController());
    final limitWidget = mathConstructionsBuildingService.createLimitWidget(); 
    if(parsedWidgetData != null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, limitWidget);
      rebuildSreenState(); 
    }
  }

  void absButtonTap(){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, textFieldService.getActiveTextFieldController());
    final absWidet = mathConstructionsBuildingService.createAbsWidget();
    if(parsedWidgetData != null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, absWidet);
      rebuildSreenState(); 
    }
  }

  void backetsButtonTap(){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, textFieldService.getActiveTextFieldController());
    final backetsWidget = mathConstructionsBuildingService.createBracketsWidget();
    if(parsedWidgetData != null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, backetsWidget);
      rebuildSreenState(); 
    }
  }

  void undefinitintegralButtonTap(){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, textFieldService.getActiveTextFieldController());
    final integralWidget = mathConstructionsBuildingService.createUndefinitIntegralWidget();
    if(parsedWidgetData != null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, integralWidget);
      rebuildSreenState(); 
    }
  }

  void integralButtonTap(){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, textFieldService.getActiveTextFieldController() );
    final integralWidget = mathConstructionsBuildingService.createIntegralWidget();
    if(parsedWidgetData!= null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, integralWidget);
      rebuildSreenState();
    }
  }
  void onDerevativeButtonTap({String? upperField, String? downField}){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, textFieldService.getActiveTextFieldController() );
    final derevativeWidget = mathConstructionsBuildingService.createDerevativeWidget(upperField,downField);
    if(parsedWidgetData!= null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, derevativeWidget);
      rebuildSreenState();
    }
  }

  void selectNextFocus(){
    final shouldNotCreateNewField = textFieldService.trySelectNextFocus();
    if(!shouldNotCreateNewField){
      final parsedWidgetData = parsersService.parseWidgetList(_formulaGroopWidgets, textFieldService.getActiveTextFieldController());
      final textFieldConstruction = mathConstructionsBuildingService.createTextField(replaceOldFocus: true);
        if(parsedWidgetData != null){
          dataHandler.addToWidgetTree(parsedWidgetData, [textFieldConstruction.construction]); 
          rebuildSreenState();
        }
    } 
  }

  void createCharWidgets(String char){
    // один сплошной костыль 
    final activeTextFieldController = textFieldService.getActiveTextFieldController();
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(_formulaGroopWidgets, activeTextFieldController);
    List<Widget> textField=[];
    if(textFieldService.getActiveTextFieldController().text.isEmpty){
      textFieldService.getActiveTextFieldController().text = char; 
      textField.add(mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
    }else{
      textField.add(mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
      textFieldService.getActiveTextFieldController().text = char; 
      textField.add(mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
    }
    if (parsedWidgetData != null) {
      dataHandler.addToWidgetTree(parsedWidgetData, textField);
      rebuildSreenState();
    }
    
  }

  void selectBackFocus(){
    textFieldService.selectBackFocus(); 
  }

  void backspaceButtonTap() {
    final activeController = textFieldService.getActiveTextFieldController();
    if (activeController.text.isNotEmpty) {
      textFieldService.deleteLastChar();
    } else {
      CountData? fieldsInElementCountData;
      final parsedWidgets = parsersService.parseWidgetListWithReplacment(
        _formulaGroopWidgets, 
        activeController
      );
      if (parsedWidgets != null) {
        fieldsInElementCountData = deletingParserService.
            getCountOfTextFieldsIn(parsedWidgets.wigetData!, activeController);
      }
      if (fieldsInElementCountData != null && fieldsInElementCountData.count > 1) {
        _deleteField(parsedWidgets!, fieldsInElementCountData.fieldLocation);
      } else {
        _replaceElementByFiled(activeController);
      }
      rebuildSreenState(hard: true);
    }
  }

  void _deleteField(ReturnData parsedWidgets, int fieldLocation) {
    final isSuccess =
        textFieldService.deleteCurrentController(fieldLocation);
    if (isSuccess) {
      dataHandler.deleteFromWidgetTree(parsedWidgets);
    } else {
      deleteAllButtonTap();
    }
  } 

  void _replaceElementByFiled(TextEditingController activeController) { 
    final elementToReplace = deletingParserService.parseWidgetList(
      _formulaGroopWidgets, 
      activeController
    );
    final isControllersDeleted =
        textFieldService.deleteElementFields(elementToReplace?.isGroop);
    if (!isControllersDeleted) {
      deleteAllButtonTap();
      return; 
    }

    if (elementToReplace != null) {
      final newField = mathConstructionsBuildingService.createTextField(
        replaceOldFocus: false, 
        standartSize: true
      );
      dataHandler.replaceWidgetInTree(elementToReplace, newField);
    } else {
      final dataToReplaceField = parsersService.parseWidgetListWithReplacment(
        _formulaGroopWidgets,
        activeController
      );
      if (dataToReplaceField != null) {
        dataHandler.deleteFromWidgetTree(dataToReplaceField);
      }
    }
  }

  void deleteAllButtonTap(){
    _formulaGroopWidgets.clear();
    textFieldService.deleteAllTextFields(); 
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
        textFieldService.requestFocusToActiveTextField();
      }
    );
  }
}