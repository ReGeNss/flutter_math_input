import 'package:flutter/material.dart';
import '../interfaces/index.dart';
import '../services/math_constructions_building.dart';
import '../widgets/supportive_widgets/index.dart';

class FormulasTreeDeletingParser {
  ParsedWidgetsData? _parsedData;
  bool _isLoopWindingDown = false ; 

  int counter = 0;
  int textFieldLocation = 0;

  ParsedWidgetsData? getElement(
    List<Widget> array, 
    TextEditingController activeTextFieldController,
    ) {
    _parsedData = null;
    _isLoopWindingDown = false; 
    _parseWidgets(array, activeTextFieldController);
    
    return _parsedData;
  }


  ElementFieldsData getCountOfTextFieldsIn(
    List<Widget> array, 
    TextEditingController activeTextFieldController,
  ) {
    counter = 0; 
    textFieldLocation = 0;
    _parseCountOfTextFields(array, activeTextFieldController);

    return ElementFieldsData(counter, textFieldLocation); 
  }

  ParsedWidgetsData? _parseWidgets(
    List<Widget> array, 
    TextEditingController activeTextFieldController,
  ) {
    final length = array.length;
    for (int index = 0; length > index; index += 1) {
      if(array[index].isSingleChild){
        final widget = array[index];
        if (widget.singleChild != null) {
          _parseWidgets(
            [widget.singleChild!],
            activeTextFieldController,
          );
          if(_isLoopWindingDown && widget.key != null && widget.key is ObjectKey){
            final keyType = MathConstructionKey.getKey(widget.key as ObjectKey);
            _isLoopWindingDown = false;
            _parsedData = ParsedWidgetsData(
              index: index, 
              widgetData: array, 
              isGroup: keyType is GroupMathConstructionKey,
            );
          }
        }
      }else if(array[index].isMultiChild){
        final list = array[index];
        _parseWidgets(
          list.multiChild,
          activeTextFieldController,
        );
        
        if(_isLoopWindingDown && list.key != null && list.key is ObjectKey){
          final keyType = MathConstructionKey.getKey(list.key as ObjectKey);
          _isLoopWindingDown = false;
          _parsedData = ParsedWidgetsData(
            index: index, 
            widgetData: array,
            isGroup: keyType is GroupMathConstructionKey,
          );
        }
      }else if(array[index] is TextFieldWrapper){
        final widget =
              (array[index] as TextFieldWrapper).textField as TextField;
        _parseWidgets([widget], activeTextFieldController);
        if(_isLoopWindingDown && widget.key != null && widget.key is ObjectKey){
          _isLoopWindingDown = false;
          _parsedData = ParsedWidgetsData(index: index, widgetData: array);
        } 
      }else if(array[index] is TextField){
        final textFieldWidget = array[index] as TextField;
        if (textFieldWidget.controller == activeTextFieldController) {
          _isLoopWindingDown = true;

          return ParsedWidgetsData(widgetData: array, index: index);
        }
      }
    }
    
    return null;
  }

  void _parseCountOfTextFields(
    List<Widget> array, 
    TextEditingController activeTextFieldController,
    ) {
    final length = array.length;
    for (int index = 0; length > index; index += 1) {
      if(array[index] is TextFieldWrapper){
        counter += 1;
        final textField = 
          (array[index] as TextFieldWrapper).textField as TextField;
        if(textField.controller == activeTextFieldController){
          textFieldLocation = counter;
        }
      }else if(array[index] is SingleChildRenderObjectWidget){
        final widget = array[index] as SingleChildRenderObjectWidget;
        if(widget.child != null){
          _parseCountOfTextFields([widget.child!], activeTextFieldController);
        }
      }else if(array[index] is MultiChildRenderObjectWidget){
        final widget = array[index] as MultiChildRenderObjectWidget;
        _parseCountOfTextFields(widget.children, activeTextFieldController);
      }
    }
  } 
}

class ElementFieldsData{
  final int fieldsCount; 
  final int ourFieldLocation;

  ElementFieldsData(this.fieldsCount, this.ourFieldLocation);
}
