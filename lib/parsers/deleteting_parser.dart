import 'package:flutter/material.dart';
import 'package:math_keyboard/parsers/formulas_tree_parsers_and_handler.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

class FormulasTreeDeletingParser {
  ReturnData? _parsedData;
  bool _isReverse = false ; 

  ReturnData? parseWidgetList(
    List<Widget> array, 
    TextEditingController activeTextFieldController
    ) {
    _parsedData = null;
    _isReverse = false; 
    _parseWidgets(array, activeTextFieldController);
    return _parsedData;
  }

  int counter = 0;
  int textFieldLocation = 0;

  CountData getCountOfTextFieldsIn(List<Widget> array, TextEditingController activeTextFieldController) {
    counter = 0; 
    textFieldLocation = 0;
    _parseCountOfTextFields(array, activeTextFieldController);
    return CountData(counter, textFieldLocation); 
  }

  ReturnData? _parseWidgets(
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
            if(_isReverse && row.key != null && row.key is ValueKey && (row.key as ValueKey).value != ElementsType.exponentiationElement ){
              _isReverse = false; 
              if((row.key as ValueKey).value == ElementsType.indefiniteIntegralElement) {
                _parsedData = ReturnData(index: index, wigetData: array, isGroop: true);
                return null;
              } 
              _parsedData = ReturnData(index: index, wigetData: array);
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
            if(_isReverse && list.key != null && list.key is ValueKey ){
              final keyValue = (list.key as ValueKey).value;
              _isReverse = false;
              if(keyValue == ElementsType.fracElement) {
                _parsedData = ReturnData(index: index, wigetData: array, isGroop: true);
                return null;
              }
              _parsedData = ReturnData(index: index, wigetData: array,);
            }
            break;
          }
        case const (TextField):
          {
            final textFieldWidget = array[index] as TextField;
            if (textFieldWidget.controller == activeTextFieldController) {
              _isReverse = true;
              return ReturnData(
                  wigetData: array, index: index, widget: textFieldWidget);
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
              if(_isReverse && widget.key != null && widget.key is ValueKey){
                final keyValue = (widget.key as ValueKey).value;
                _isReverse = false; 
                if(
                  keyValue == ElementsType.derevativeElement
                  || keyValue == ElementsType.logElement
                ){
                  _parsedData = ReturnData(index: index, wigetData: array, isGroop: true);
                  return null;
                }
                _parsedData = ReturnData(index: index, wigetData: array);
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
            if(_isReverse && list.key != null && list.key is ValueKey){
               _isReverse = false;
              _parsedData = ReturnData(index: index, wigetData: array);
            }
            break;
          }
        case const (Positioned):
          {
            final widget = array[index] as Positioned;
            _parseWidgets(
                [widget.child], activeTextFieldController);
            if(_isReverse && widget.key != null && widget.key is ValueKey){
              _isReverse = false;
              _parsedData = ReturnData(index: index, wigetData: array);
            }
            break;
          }
        case const (ExpRowWidget) :
        {
          final widget = array[index] as ExpRowWidget;
            if(widget.child != null){
              _parseWidgets([widget.child!], activeTextFieldController);
            }
            if(_isReverse){
              _isReverse = false;
              _parsedData = ReturnData(index: index, wigetData: array, isGroop: true);
            }
          break;
        }
        case const (BacketsWidget):
        {
          final widget = (array[index] as BacketsWidget).child as Row; 
            _parseWidgets(widget.children, activeTextFieldController); 
          if(_isReverse){ 
              _isReverse = false;
              _parsedData = ReturnData(index: index, wigetData: array);
            }
          break;
        }
        case const (ArgumentWidget): 
        {
          final widget = (array[index] as ArgumentWidget).child as Row; 
          _parseWidgets(widget.children, activeTextFieldController); 
          if(_isReverse && widget.key != null && widget.key is ValueKey){ 
            _isReverse = false;
            _parsedData = ReturnData(index: index, wigetData: array);
          }
          break; 
        }
        case const (IntegralWidget): 
        {
            final widget =
                (array[index] as IntegralWidget).child as SizedBox;
            if (widget.child != null) {
              _parseWidgets(
                [widget.child!], 
                activeTextFieldController
              );
            }
            if(_isReverse){
              _isReverse = false;
              _parsedData = ReturnData(index: index, wigetData: array, isGroop: true);
            }
            break; 
        }
        case const (TextFieldWidgetHandler):
        {
           final widget =
                (array[index] as TextFieldWidgetHandler).textField as TextField;
          _parseWidgets([widget], activeTextFieldController);
          if(_isReverse && widget.key != null && widget.key is ValueKey){
            _isReverse = false;
            _parsedData = ReturnData(index: index, wigetData: array);
          } 
          break; 
        }
        case const (LimStackWidget):
        {
          final widget = (array[index] as LimStackWidget).child;
          _parseWidgets([widget!], activeTextFieldController);
          if(_isReverse){
            _isReverse = false; 
            _parsedData = ReturnData(index: index, wigetData: array, isGroop: true);
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
      switch (array[index].runtimeType) {
        case const (Row):
          {
            final row = array[index] as Row;
            _parseCountOfTextFields(
              row.children,
              activeTextFieldController,
            );
            break;
          }
        case const (Column):
          {
            final list = array[index] as Column;
            _parseCountOfTextFields(
              list.children,
              activeTextFieldController,
            );
            break;
          }
        case const (TextField):
          {
            counter +=1;
            final textField = array[index] as TextField;
            if(textField.controller == activeTextFieldController) {
              textFieldLocation = counter;
            }
            break;
          }
        case const (SizedBox):
          {
            final widget = array[index] as SizedBox;
            if (widget.child != null) {
              _parseCountOfTextFields(
                [widget.child!],
                activeTextFieldController,
              );
            }
            
            break;
          }
        case const (Stack):
          {
            final list = array[index] as Stack;
            _parseCountOfTextFields(
              list.children,
              activeTextFieldController
            );
            break;
          }
        case const (Positioned):
          {
            final widget = array[index] as Positioned;
            _parseCountOfTextFields([widget.child], activeTextFieldController);
            break;
          }
        case const (ExpRowWidget):
        {
          final widget = array[index] as ExpRowWidget;
            if(widget.child != null){
              _parseCountOfTextFields([widget.child!], activeTextFieldController);
            }
          break;
        }
        case const (BacketsWidget):
        {
          final widget = (array[index] as BacketsWidget).child as Row; 
          _parseCountOfTextFields(widget.children, activeTextFieldController); 
          break;
        }
        case const (ArgumentWidget): 
        {
          final widget = (array[index] as ArgumentWidget).child as Row; 
          _parseCountOfTextFields(widget.children, activeTextFieldController); 
          break; 
        }
        case const (IntegralWidget): 
        {
            final widget = (array[index] as IntegralWidget).child as SizedBox;
            if (widget.child != null) {
              _parseCountOfTextFields([widget.child!], activeTextFieldController);
            }
            break; 
        }
        case const (TextFieldWidgetHandler):
        {
          final widget = (array[index] as TextFieldWidgetHandler).textField as TextField;
          _parseCountOfTextFields([widget], activeTextFieldController);    
          break; 
        }
        case const (LimStackWidget):
        {
          final widget = (array[index] as LimStackWidget).child;
          _parseCountOfTextFields([widget!], activeTextFieldController);
          break; 
        }
      }
    }
  } 
}

class CountData{
  CountData(this.count, this.fieldLocation);

  final int count; 
  final int fieldLocation; 
}