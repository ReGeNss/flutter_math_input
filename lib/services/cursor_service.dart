import 'package:flutter/material.dart';
import '../interfaces/index.dart';
import '../parsers/index.dart';
import 'index.dart';

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
    try{
      _textFieldService.selectNextFocus();
    } catch (e){
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
