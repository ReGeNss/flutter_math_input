import 'package:flutter/material.dart';
import 'package:math_keyboard/services/formula_to_tex_parser.dart';
import 'package:math_keyboard/services/formulas_tree_parsers_and_handler.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';
import 'package:math_keyboard/services/widgets_data_handler.dart';

class KeyboardModel extends ChangeNotifier{
  late final TextFieldHandleAndCreateService textFieldService; 
  late final MathConstructionsBuilding mathConstructionsBuildingService; 
  late final FormulasTreeParsersService parsersService; 
  late final WidgetsDataHandler dataHandler; 
  late final FormulaToTexParser texParsingService; 

  bool update = true; 
  String? formulaInTeX; 

  KeyboardModel(){
    textFieldService = TextFieldHandleAndCreateService();
    mathConstructionsBuildingService = MathConstructionsBuilding(textFieldService: textFieldService);
    parsersService = FormulasTreeParsersService();
    dataHandler = WidgetsDataHandler(); 
    texParsingService = FormulaToTexParser(); 
    initialization();
  }
  List<Widget> formulaGroopWidgets =[];


  void initialization(){
    final defaultTextField = mathConstructionsBuildingService.initialization(); 
    formulaGroopWidgets.add(defaultTextField); 
    // notifyListeners();
  }
  void onFracButtonTap(){
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldData.controller);
    final fracWidget = mathConstructionsBuildingService.createFracWidget();
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, fracWidget);
      rebuildSreenState();
    }
  }

  void namedFunctionButtonTap(String functionName, ElementsType type){
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldData.controller);
    final fracWidget = mathConstructionsBuildingService.createNamedFunctionWidget(functionName, type); 
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, fracWidget); 
      rebuildSreenState(); 
    }
  }

  void onExpButtonTap(){
    ReturnData? parsedWidgets;  
    final activeTextFieldController = textFieldService.activeTextFieldData.controller; 
    if(activeTextFieldController.text.isNotEmpty){
      parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, activeTextFieldController); 
    }
    else{
        parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, activeTextFieldController);
        if(parsedWidgets?.index != null && parsedWidgets!.index! >= 1){
          parsedWidgets.index = parsedWidgets.index! - 1;
        }
      
    }
    if(parsedWidgets != null && parsedWidgets.index != null){
      final baseWidget = parsedWidgets.wigetData![parsedWidgets.index!];
      final expWidget = mathConstructionsBuildingService.createExpWidget(baseWidget);
      dataHandler.replaceWidgetInTree(parsedWidgets, expWidget);
      rebuildSreenState();
    }
    
  }

  void sqrtButtonTap(){
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldData.controller);
    final sqrtWidget = mathConstructionsBuildingService.createSqrtWidget(); 
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, sqrtWidget);
      rebuildSreenState();
    }
  }

  void logButtonTap(){
    final activeTextFieldController = textFieldService.activeTextFieldData.controller;
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, activeTextFieldController);
    final logWidget = mathConstructionsBuildingService.createLogWidget(); 
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, logWidget);
      rebuildSreenState(); 
    }
  }

  void limButtonTap(){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldData.controller);
    final limitWidget = mathConstructionsBuildingService.createLimitWidget(); 
    if(parsedWidgetData != null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, limitWidget);
      rebuildSreenState(); 
    }
  }

  void absButtonTap(){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldData.controller);
    final absWidet = mathConstructionsBuildingService.createAbsWidget();
    if(parsedWidgetData != null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, absWidet);
      rebuildSreenState(); 
    }
  }

  void backetsButtonTap(){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldData.controller);
    final backetsWidget = mathConstructionsBuildingService.createBracketsWidget();
    if(parsedWidgetData != null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, backetsWidget);
      rebuildSreenState(); 
    }
  }

  void undefinitintegralButtonTap(){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldData.controller);
    final integralWidget = mathConstructionsBuildingService.createUndefinitIntegralWidget();
    if(parsedWidgetData != null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, integralWidget);
      rebuildSreenState(); 
    }
  }

  void integralButtonTap(){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldData.controller );
    final integralWidget = mathConstructionsBuildingService.createIntegralWidget();
    if(parsedWidgetData!= null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, integralWidget);
      rebuildSreenState();
    }
  }
  void onDerevativeButtonTap({String? upperField, String? downField}){
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldData.controller );
    final derevativeWidget = mathConstructionsBuildingService.createDerevativeWidget(upperField,downField);
    if(parsedWidgetData!= null){
      dataHandler.replaceWidgetInTree(parsedWidgetData, derevativeWidget);
      rebuildSreenState();
    }
  }

  void selectNextFocus(){
    final shouldNotCreateNewField = textFieldService.trySelectNextFocus();
    if(!shouldNotCreateNewField){
      final parsedWidgetData = parsersService.parseWidgetList(formulaGroopWidgets, textFieldService.activeTextFieldData.controller);
      final textfield = mathConstructionsBuildingService.createTextField(replaceOldFocus: true);
        if(parsedWidgetData != null){
          dataHandler.addToWidgetTree(parsedWidgetData, [textfield]); 
          rebuildSreenState();
        }
      // notifyListeners();
      
    } 
  }

  void createCharWidgets(String char){
    // один сплошной костыль 
    final activeTextFieldController = textFieldService.activeTextFieldData.controller;
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, activeTextFieldController);
    List<Widget> textField=[];
    if(textFieldService.activeTextFieldData.controller.text.isEmpty){
      textFieldService.activeTextFieldData.controller.text = char; 
      textField.add(mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
    }else{

      textField.add(mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
      textFieldService.activeTextFieldData.controller.text = char; 
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

  void backspaceButtonTap(){
    final activeController = textFieldService.activeTextFieldData.controller; 
    if(activeController.text.isNotEmpty){
      final textLength =activeController.text.length;
      activeController.text = activeController.text.substring(0,textLength-1); 
    }else{
      final isControllerDeleted = textFieldService.deleteCurrentActiceField();
    if(isControllerDeleted){
      final parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets,activeController); 
      if(parsedWidgets != null){
      dataHandler.deleteFromWidgetTree(parsedWidgets); 
    }
    }else{
      deleteAllButtonTap(); 
    }
     
    rebuildSreenState();
    }
     
    
  }

  void rebuildSreenState(){
    update = false; 
    notifyListeners();
    Future.delayed(
      const Duration(milliseconds: 20)
    ).then(
      (_) {
        update = true;
        notifyListeners();
      },
    );
  }

  void deleteAllButtonTap(){
    formulaGroopWidgets.clear();
    textFieldService.deleteAllTextFields(); 
    initialization(); 
    notifyListeners();
  }
  // void updateScreen(){
    // notifyListeners(); 
  // }


}