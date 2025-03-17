import 'package:flutter/material.dart';
import 'package:math_keyboard/parsers/formulas_tree_parsers.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

class FormulasTreeDeletingParser {
  ParsedWidgetsData? _parsedData;
  bool _isLoopWindingDown = false ; 

  ParsedWidgetsData? getElement(
    List<Widget> array, 
    TextEditingController activeTextFieldController
    ) {
    _parsedData = null;
    _isLoopWindingDown = false; 
    _parseWidgets(array, activeTextFieldController);
    return _parsedData;
  }

  int counter = 0;
  int textFieldLocation = 0;

  ElementFieldsData getCountOfTextFieldsIn(List<Widget> array, TextEditingController activeTextFieldController) {
    counter = 0; 
    textFieldLocation = 0;
    _parseCountOfTextFields(array, activeTextFieldController);
    return ElementFieldsData(counter, textFieldLocation); 
  }

  ParsedWidgetsData? _parseWidgets(
    List<Widget> array, 
    TextEditingController activeTextFieldController
  ) {
    final length = array.length;
    for (int index = 0; length > index; index += 1) {
      switch (array[index].runtimeType) {
        case const (Row):
          {
            final row = array[index] as Row;
            _parseWidgets(
              row.children,
              activeTextFieldController,
            );
            if(_isLoopWindingDown && row.key != null && row.key is ObjectKey && ((row.key as ObjectKey).value as MathConstructionKey).type != ElementsType.exponentiationElement ){
              _isLoopWindingDown = false; 
              _parsedData = ParsedWidgetsData(index: index, wigetData: array);
            }
            break;
          }
        case const (Column):
          {
            final list = array[index] as Column;
             _parseWidgets(
              list.children,
              activeTextFieldController,
            );
            if(_isLoopWindingDown && list.key != null && list.key is ObjectKey){
              final keyType = ((list.key as ObjectKey).value as MathConstructionKey).type;
              _isLoopWindingDown = false;
              if(keyType == ElementsType.fracElement) {
                _parsedData = ParsedWidgetsData(index: index, wigetData: array, isGroop: true);
                return null;
              }
              _parsedData = ParsedWidgetsData(index: index, wigetData: array,);
            }
            break;
          }
        case const (TextField):
          {
            final textFieldWidget = array[index] as TextField;
            if (textFieldWidget.controller == activeTextFieldController) {
              _isLoopWindingDown = true;
              return ParsedWidgetsData(wigetData: array, index: index);
            }
            break;
          }
        case const (SizedBox):
          {
            final widget = array[index] as SizedBox;
            if (widget.child != null) {
              _parseWidgets(
                [widget.child!],
                activeTextFieldController,
              );
              if(_isLoopWindingDown && widget.key != null && widget.key is ObjectKey){
                final keyType = ((widget.key as ObjectKey).value as MathConstructionKey).type;
                _isLoopWindingDown = false; 
                if(keyType == ElementsType.derevativeElement){
                  _parsedData = ParsedWidgetsData(index: index, wigetData: array, isGroop: true);
                  return null;
                }
                _parsedData = ParsedWidgetsData(index: index, wigetData: array);
              }
            }
            break;
          }
        case const (Stack):
          {
            final list = array[index] as Stack;
            _parseWidgets(
              list.children,
              activeTextFieldController,
            );
            if(_isLoopWindingDown && list.key != null && list.key is ObjectKey){
               _isLoopWindingDown = false;
              _parsedData = ParsedWidgetsData(index: index, wigetData: array);
            }
            break;
          }
        case const (Positioned):
          {
            final widget = array[index] as Positioned;
            _parseWidgets(
                [widget.child], activeTextFieldController);
            if(_isLoopWindingDown && widget.key != null && widget.key is ObjectKey){
              _isLoopWindingDown = false;
              _parsedData = ParsedWidgetsData(index: index, wigetData: array);
            }
            break;
          }
        case const (BacketsWidget):
        {
          final widget = (array[index] as BacketsWidget).child as Row; 
            _parseWidgets(widget.children, activeTextFieldController); 
          if(_isLoopWindingDown){ 
              _isLoopWindingDown = false;
              _parsedData = ParsedWidgetsData(index: index, wigetData: array);
            }
          break;
        }
        case const (RelayedPositioned):
        {
          final widget = array[index] as RelayedPositioned;
          _parseWidgets([widget.wrappedWidget!], activeTextFieldController);
          if(_isLoopWindingDown && widget.key != null && widget.key is ObjectKey){
            _isLoopWindingDown = false;
            _parsedData = ParsedWidgetsData(index: index, wigetData: array);
          }
          break;
        }
        case const (WidgetDynamicSizeWrapper): 
        {
          final widget = array[index] as WidgetDynamicSizeWrapper;
          _parseWidgets([widget.wrappedWidget], activeTextFieldController);
          if(_isLoopWindingDown && widget.key != null && widget.key is ObjectKey){
            _isLoopWindingDown = false;
            final keyType = ((widget.key as ObjectKey).value as MathConstructionKey).type;
            if(keyType == ElementsType.indefiniteIntegralElement
              || keyType == ElementsType.integralElement
              || keyType == ElementsType.limitElement
              || keyType == ElementsType.logElement
            ){
              _parsedData = ParsedWidgetsData(index: index, wigetData: array, isGroop: true);
              return null;
            }
            _parsedData = ParsedWidgetsData(index: index, wigetData: array);
          }
          break; 
        }
        case const (ArgumentWidget): 
        {
          final widget = (array[index] as ArgumentWidget).child as Row; 
          _parseWidgets(widget.children, activeTextFieldController); 
          if(_isLoopWindingDown && widget.key != null && widget.key is ObjectKey){ 
            _isLoopWindingDown = false;
            _parsedData = ParsedWidgetsData(index: index, wigetData: array);
          }
          break; 
        }
        case const (TextFieldWidgetHandler):
        {
           final widget =
                (array[index] as TextFieldWidgetHandler).textField as TextField;
          _parseWidgets([widget], activeTextFieldController);
          if(_isLoopWindingDown && widget.key != null && widget.key is ObjectKey){
            _isLoopWindingDown = false;
            _parsedData = ParsedWidgetsData(index: index, wigetData: array);
          } 
          break; 
        }
      }
    }
    return null;
  }

  void _parseCountOfTextFields(List<Widget> array, TextEditingController activeTextFieldController) {
    final length = array.length;
    for (int index = 0; length > index; index += 1) {
      if(array[index] is TextFieldWidgetHandler){
        counter += 1;
        final textField = (array[index] as TextFieldWidgetHandler).textField as TextField;
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
  ElementFieldsData(this.fieldsCount, this.ourFieldLocation);

  final int fieldsCount; 
  final int ourFieldLocation; 
}