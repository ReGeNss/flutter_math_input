import 'package:flutter/material.dart';
import 'package:flutter_math_input/parsers/formulas_tree_parsers.dart';
import 'package:flutter_math_input/services/math_constructions_building.dart';
import 'package:flutter_math_input/services/text_field_handle_and_create.dart';
import 'package:flutter_math_input/services/widgets_data_handler.dart';

import '../interfaces/index.dart';

class CursorImp extends CursorService {
  final TextFieldHandleAndCreateService _textFieldService;
  final MathConstructionsBuilder _mathConstructionsBuildingService;
  final FormulasTreeParsersService _parsersService = FormulasTreeParsersService();
  final List<Widget> _formulaGroupWidgets;

  CursorImp(
    TextFieldHandleAndCreateService textFieldService, 
    MathConstructionsBuilder mathConstructionsBuildingService,
    List<Widget> formulaGroupWidgets,
    super.updateStream,
    )
      : _textFieldService = textFieldService,
        _mathConstructionsBuildingService = mathConstructionsBuildingService,
        _formulaGroupWidgets = formulaGroupWidgets;

  @override
  void requestFocusToActiveTextField() {
    _textFieldService.requestFocusToActiveTextField();
  }

  @override
  void selectBackFocus() {
    _textFieldService.selectBackFocus();
  }

  @override
  void selectNextFocus() {
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
      WidgetsDataHandler.addToWidgetTree(parsedWidgetData, [textField]); 
      requestFormulaUpdate();
    } 
  }
  
}
