import 'package:flutter/material.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

class KeyboardModel extends ChangeNotifier{
  late final TextFieldHandleAndCreateService textFieldHadler; 
  late final MathConstructionsBuilding mathConstructionsBuildingService; 

  KeyboardModel(){
    textFieldHadler = TextFieldHandleAndCreateService();
    mathConstructionsBuildingService = MathConstructionsBuilding(textFiledService: textFieldHadler);
    initialization();
  }
  List<Widget> formulaGroopWidgets =[];


  void initialization(){
    final defaultTextField = mathConstructionsBuildingService.initialization(); 
    formulaGroopWidgets.add(defaultTextField); 
    // notifyListeners();
  }

  void deleteAllButtonTap(){
    formulaGroopWidgets.clear();
    textFieldHadler.clearAllData(); 
    initialization(); 
  }
  void updateScreen(){
    notifyListeners(); 
  }
}