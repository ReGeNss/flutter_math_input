import 'package:flutter/material.dart';
import 'package:math_keyboard/services/formulas_tree_parsers_and_handler.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';
import 'package:math_keyboard/services/widgets_data_handler.dart';

class KeyboardModel extends ChangeNotifier{
  late final TextFieldHandleAndCreateService textFieldHadler; 
  late final MathConstructionsBuilding mathConstructionsBuildingService; 
  late final FormulasTreeParsersService parsersService; 

  KeyboardModel(){
    textFieldHadler = TextFieldHandleAndCreateService();
    mathConstructionsBuildingService = MathConstructionsBuilding(textFiledService: textFieldHadler);
    parsersService = FormulasTreeParsersService(); 
    initialization();
  }
  List<Widget> formulaGroopWidgets =[];


  void initialization(){
    final defaultTextField = mathConstructionsBuildingService.initialization(); 
    formulaGroopWidgets.add(defaultTextField); 
    // notifyListeners();
  }
  void onFracButtonTap(){
    final parsedWidgets = parsersService.parseWidgetList(formulaGroopWidgets, textFieldHadler.activeTextFieldController);
    final fracWidget = mathConstructionsBuildingService.createFracWidget();
    if(parsedWidgets != null){
      WidgetsDataHandler().replaceWidgetInTree(parsedWidgets, fracWidget);
      notifyListeners(); 
    }
  }

  void selectNextFocus(){
    textFieldHadler.selectNextFocus(); 
  }
  void selectBackFocus(){
    textFieldHadler.selectBackFocus(); 
  }

  void deleteAllButtonTap(){
    formulaGroopWidgets.clear();
    textFieldHadler.clearAllData(); 
    initialization(); 
    notifyListeners();
  }
  void updateScreen(){
    notifyListeners(); 
  }


}