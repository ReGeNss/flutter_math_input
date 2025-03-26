import 'package:flutter/material.dart';
import 'package:flutter_math_input/math_constructions/index.dart';
import '../services/math_constructions_building.dart';
import '../services/text_field_handle_and_create.dart';

class FormulaToTexParser {
  String formulaInKatex = '';
  String start(List<Widget> widgetList) {
    try{
      formulaInKatex = '';
      _formulaParser(widgetList);
      return formulaInKatex;
    }catch(e){
      return '\\text{something went wrong, retry...}';
    }
  }

  String? _formulaParser(List<Widget> widgetList) {
    for (final element in widgetList) {
      if(element.singleChild != null) {
        if(element.key != null && element.key is ObjectKey){
          final construction = _getConstruction(element);
          if(construction is SimpleMathConstuction){
            _addToTeXData(
              () => _parseElement([element.singleChild!], construction.katexExp)
            );
          }else{
            construction as GroopMathConstruction;
            final widgetsTocheck = element.isMultiChildWidget ? element.multiChild : [element.singleChild!];
            _addToTeXData(
              () => _parseGroop(widgetsTocheck, construction.katexExp, construction.fieldsLocation)
            );
          }
        }else{
          _formulaParser([element.singleChild!]);
        }
      }else if(element.isMultiChildWidget){
        if(element.key != null && element.key is ObjectKey){
          final construction = _getConstruction(element);
          if(construction is SimpleMathConstuction){
            _addToTeXData(
              () => _parseElement(element.multiChild, construction.katexExp)
            );
          }else{
            construction as GroopMathConstruction;
            final widgetsTocheck = element.isMultiChildWidget ? element.multiChild : [element.singleChild!];
            _addToTeXData(
              () => _parseGroop(widgetsTocheck, construction.katexExp, construction.fieldsLocation)
            );
          }
        }else{
          _formulaParser(element.multiChild);
        }
      }else if(element is TextFieldWidgetHandler){
        final text = element.textFieldData.controller.text;
        formulaInKatex = formulaInKatex + text;
        return text;
      }
    }
    return null;
  }

  MathConstruction _getConstruction(Widget widget){
    final key = widget.key as ObjectKey;
    final keyValue = key.value as MathConstructionKey;
    return keyValue.construction;
  }

  void _addToTeXData(Function parseFunc) {
    final intermediateKatexExp = formulaInKatex;
    formulaInKatex = '';
    String parsedKatexExp = '';
    parsedKatexExp = parseFunc();
    formulaInKatex = intermediateKatexExp + parsedKatexExp;
  }

  String _parseElement(List<Widget> widgets, List<String> katexExp){
    String exp = '';
    for(final element in widgets){
      _formulaParser([element]);
      exp+=formulaInKatex;
      formulaInKatex = '';
    }
    return katexExp[0] + exp + katexExp[1];
  }

  String _parseGroop(List<Widget> widgets, List<String> katexFormula,List<int> widgetsTocheck){
    if(widgets.length < widgetsTocheck.length){
      if(widgets[0].isMultiChildWidget){
        widgets = widgets[0].multiChild;
      }
    }

    final expressions = _getValuesFromFields(widgets, widgetsTocheck);
    String newExp = '';
    newExp+=katexFormula[0];
    for(int i = 0; i < expressions.length; i++){
      newExp+=expressions[i];
      newExp+=katexFormula[i+1];
    }
    return newExp;
  }

  List<String> _getValuesFromFields(List<Widget> widgets, List<int> widgetsTocheck){
    List<String> data = [];
    for(int i = 0; i < widgetsTocheck.length; i++){
      _formulaParser([widgets[widgetsTocheck[i]]]);
      data.add(formulaInKatex);
      formulaInKatex = '';
    }
    return data;
  }
}