import 'package:flutter/material.dart';
import 'package:math_keyboard/services/formulas_tree_parsers_and_handler.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';
import 'package:math_keyboard/services/widgets_data_handler.dart';

class KeyboardModel extends ChangeNotifier{
  late final TextFieldHandleAndCreateService textFieldService; 
  late final MathConstructionsBuilding mathConstructionsBuildingService; 
  late final FormulasTreeParsersService parsersService; 
  late final WidgetsDataHandler dataHandler; 

  bool update = true; 

  KeyboardModel(){
    textFieldService = TextFieldHandleAndCreateService();
    mathConstructionsBuildingService = MathConstructionsBuilding(textFiledService: textFieldService);
    parsersService = FormulasTreeParsersService();
    dataHandler = WidgetsDataHandler(); 
    initialization();
  }
  List<Widget> formulaGroopWidgets =[];


  void initialization(){
    final defaultTextField = mathConstructionsBuildingService.initialization(); 
    formulaGroopWidgets.add(defaultTextField); 
    // notifyListeners();
  }
  void onFracButtonTap(){
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldControllerData.controller);
    final fracWidget = mathConstructionsBuildingService.createFracWidget();
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, fracWidget);
      rebuildSreenState();
    }
  }

  void NamedFunctionButtonTap(String functionName){
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldControllerData.controller);
    final fracWidget = mathConstructionsBuildingService.createNamedFunctionWidget(functionName); 
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, fracWidget); 
      rebuildSreenState(); 
    }
  }

  void onExpButtonTap(){
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldControllerData.controller); 
    if(parsedWidgets != null){
      final baseWidget = parsedWidgets!.wigetData![parsedWidgets.index!];
      final expWidget = mathConstructionsBuildingService.createExpWidget(baseWidget);
      dataHandler.replaceWidgetInTree(parsedWidgets, expWidget);
      rebuildSreenState();
    }
    
  }

  void sqrtButtonTap(){
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldControllerData.controller);
    final sqrtWidget = mathConstructionsBuildingService.createSqrtWidget(); 
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, sqrtWidget);
      rebuildSreenState();
    }
  }

  void selectNextFocus(){
    final shouldCreateNewField =textFieldService.selectNextFocus();
    if(shouldCreateNewField){
      final parsedWidgetData = parsersService.parseWidgetList(formulaGroopWidgets, textFieldService.activeTextFieldControllerData.controller);
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
    final activeTextFieldController = textFieldService.activeTextFieldControllerData.controller;
    final parsedWidgetData = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, activeTextFieldController);
    List<Widget> textField=[];
    if(textFieldService.activeTextFieldControllerData.controller.text.isEmpty){
      textFieldService.activeTextFieldControllerData.controller.text = char; 
      textField.add(mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
      
    }else{

      textField.add(mathConstructionsBuildingService.createCharWidget(isActiveTextField: true));
      textFieldService.activeTextFieldControllerData.controller.text = char; 
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
  

  void rebuildSreenState(){
    update = false; 
    notifyListeners();
    Future.delayed(Duration(milliseconds: 20)).then((_){update = true;notifyListeners();},);
  }

  void deleteAllButtonTap(){
    formulaGroopWidgets.clear();
    textFieldService.clearAllData(); 
    initialization(); 
    notifyListeners();
  }
  // void updateScreen(){
    // notifyListeners(); 
  // }


}