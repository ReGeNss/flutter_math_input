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
    final parsedWidgets = parsersService.parseWidgetListWithReplacment(formulaGroopWidgets, textFieldService.activeTextFieldController);
    final fracWidget = mathConstructionsBuildingService.createFracWidget();
    if(parsedWidgets != null){
      dataHandler.replaceWidgetInTree(parsedWidgets, fracWidget);
      rebuildSreenState();
    }
    
    
  }

  void selectNextFocus(){
    final shouldCreateNewField =textFieldService.selectNextFocus();
    if(shouldCreateNewField){
      final parsedWidgetData = parsersService.parseWidgetList(formulaGroopWidgets, textFieldService.activeTextFieldController);
      final textfield = mathConstructionsBuildingService.createTextField();
        if(parsedWidgetData != null){
          dataHandler.addToWidgetTree(parsedWidgetData, [textfield]); 
          rebuildSreenState();
        }
      // notifyListeners();
      
    } 
  }

  void createCharWidgets(String char){
    final activeTextFieldController = textFieldService.activeTextFieldController;
    final parsedWidgetData = parsersService.parseWidgetList(formulaGroopWidgets, activeTextFieldController);
    List<Widget>? textField;
    if(textFieldService.activeTextFieldController.text.isEmpty){
      textFieldService.activeTextFieldController.text = char; 
      textField = mathConstructionsBuildingService.createCharWidget(amountOfField: 1);
      
    }
    if(parsedWidgetData != null){
          dataHandler.addToWidgetTree(parsedWidgetData, textField!); 
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