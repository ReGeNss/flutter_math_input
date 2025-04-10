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
      print("Error: $e");

      return r'\text{something went wrong, retry...}';
    }
  }

  String? _formulaParser(List<Widget> widgetList) {
    for (final element in widgetList) {
      if(element.singleChild != null) {
        if(element.key != null && element.key is ObjectKey){
          final construction = _getConstruction(element);
          if(construction is SimpleMathConstructionKey){
            _addToTeXData(
              () => _parseElement(
                [element.singleChild!], 
                construction.katexExp,
              ),
            );
          }else{
            construction as GroupMathConstructionKey;
            final widgetsToCheck = element.isMultiChild
              ? element.multiChild 
              : [element.singleChild!];
            _addToTeXData(
              () => _parseGroup(
                widgetsToCheck,
                construction.katexExp, 
                construction.fieldsLocation,
              ),
            );
          }
        }else{
          _formulaParser([element.singleChild!]);
        }
      }else if(element.isMultiChild){
        if(element.key != null && element.key is ObjectKey){
          final construction = _getConstruction(element);
          if(construction is SimpleMathConstructionKey){
            _addToTeXData(
              () => _parseElement(element.multiChild, construction.katexExp),
            );
          }else{
            construction as GroupMathConstructionKey;
            final widgetsToCheck = element.isMultiChild 
              ? element.multiChild 
              : [element.singleChild!];
            _addToTeXData(
              () => _parseGroup(
                widgetsToCheck, 
                construction.katexExp, 
                construction.fieldsLocation,
              ),
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

  MathConstructionKey _getConstruction(Widget widget){
    final key = widget.key! as ObjectKey;
    final keyValue = key.value! as MathConstructionKey;
    return keyValue;
  }

  void _addToTeXData(String Function() parseFunc) {
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

  String _parseGroup(
    List<Widget> widgets, 
    List<String> katexFormula,
    List<int> widgetsToCheck,
    )
  {
    List<Widget> fields = widgets;
    if(widgets.length < widgetsToCheck.length){
      if(widgets.first.isMultiChild){
        fields = widgets.first.multiChild;
      }
    }

    final expressions = _getValuesFromFields(fields, widgetsToCheck);
    final buffer = StringBuffer();
    buffer.write(katexFormula.first);
    for(int i = 0; i < expressions.length; i++){
      buffer.write(expressions[i]);
      buffer.write(katexFormula[i+1]);
    }

    return buffer.toString();
  }

  List<String> _getValuesFromFields(
    List<Widget> widgets,
    List<int> widgetsToCheck,
   ){
    final List<String> data = [];
    for(int i = 0; i < widgetsToCheck.length; i++){
      _formulaParser([widgets[widgetsToCheck[i]]]);
      data.add(formulaInKatex);
      formulaInKatex = '';
    }
    
    return data;
  }
}
