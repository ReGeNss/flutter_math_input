import 'package:flutter/material.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

class FormulasTreeParsersService {
  ParsedWidgetsData? _parsedData;

  ParsedWidgetsData? parseWidgetLocation(
    List<Widget> array, 
    TextEditingController activeTextFieldController
  ) {
    try{
      _parsedData = null;
      _parseWidgetLocation(array, activeTextFieldController);
      return _parsedData;
    }catch(e){
      return null;
    }
  }

  ParsedWidgetsData? parseWidgetContainerLocation(
    List<Widget> array, 
    TextEditingController activeTextFieldController
  ){
    try{
      _parsedData = null;
      _parseWidgetContainerLocation(array, activeTextFieldController); 
      return _parsedData; 
    }catch(e){
      return null;
    }
  }

  ParsedWidgetsData? _parseWidgetLocation(
      List<Widget> array, 
      TextEditingController activeTextFieldController
  ) {
    final length = array.length;
    ParsedWidgetsData? data;
    for (int index = 0; length > index; index += 1) {
      switch (array[index].runtimeType) {
        case const (Row):
          {
            final row = array[index] as Row;
            data = _parseWidgetLocation(
              row.children,
              activeTextFieldController,
            );
            if (data != null) {
              return data;
            }
            break;
          }
        case const (Column):
          {
            final list = array[index] as Column;
            data = _parseWidgetLocation(
              list.children,
              activeTextFieldController,
            );
            if (data != null) {
              return data;
            }
            break;
          }
        case const (TextField):
          {
            final textFieldWidget = array[index] as TextField;
            if (textFieldWidget.controller == activeTextFieldController) {
              return ParsedWidgetsData(wigetData: array, index: index);
            }
            break;
          }
        case const (SizedBox):
          {
            final widget = array[index] as SizedBox;
            if (widget.child != null) {
              data = _parseWidgetLocation(
                [widget.child!],
                activeTextFieldController,
              );
              if (data != null) {
                data.index = index;
                data.wigetData = array;
                _parsedData ??= data;
              }
            }
            break;
          }
        case const (Stack):
          {
            final list = array[index] as Stack;
            data = _parseWidgetLocation(
              list.children,
              activeTextFieldController,
            );
            break;
          }
        case const (Positioned):
          {
            final widget = array[index] as Positioned;
            data = _parseWidgetLocation(
              [widget.child],
              activeTextFieldController
            );
            if (data != null) {
              if(data.index == null && data.wigetData == null){
                data.index = 0; 
                data.wigetData = [widget.child]; 
              }
              if (_parsedData == null) {
                _parsedData = data;
                return null;
              }
            }
            break;
          }
        case const (BacketsWidget):
        {
          final widget = (array[index] as BacketsWidget).child as Row; 
          data = _parseWidgetLocation(widget.children, activeTextFieldController); 
          if (data != null) {
            return data;
          }
          break;
        }
        case const (ArgumentWidget): 
        {
          final widget = (array[index] as ArgumentWidget).child as Row; 
          data = _parseWidgetLocation(widget.children, activeTextFieldController); 
          if (data != null) {
            return data;
          }
          break; 
        }
        case const (RelayedPositioned):
        {
          final widget = array[index] as RelayedPositioned;
          data = _parseWidgetLocation([widget.widgetToWrap], activeTextFieldController);
          if (data != null) {
            if(data.index == null && data.wigetData == null){
              data.index = 0; 
              data.wigetData = [widget.widgetToWrap]; 
            }
            if (_parsedData == null) {
              _parsedData = data;
              return null;
            }
          }
          break;
        }
        case const (WidgetDynamicSizeWrapper):
        {
          final widget = array[index] as WidgetDynamicSizeWrapper;
          data = _parseWidgetLocation([widget.wrappedWidget], activeTextFieldController);
          if (data != null) {
            if(data.index == null && data.wigetData == null){
              data.index = 0; 
              data.wigetData = [widget.wrappedWidget]; 
            }
            if (_parsedData == null) {
              _parsedData = data;
              return null;
            }
          }
          break;
        }
        case const (TextFieldWidgetHandler):
        {
          final widget =
                (array[index] as TextFieldWidgetHandler).textField as TextField;
          data = _parseWidgetLocation(
            [widget],
            activeTextFieldController);
          if (data != null) {
            return data;
          }
          break; 
        }
      }
    }
    return null;
  }

  ParsedWidgetsData? _parseWidgetContainerLocation(List<Widget> array,
      TextEditingController activeTextFieldController,
      {bool isFromRowOrColumn = false}) {
    final length = array.length;
    ParsedWidgetsData? data;
    for (int index = 0; length > index; index += 1) {
      switch (array[index].runtimeType) {
        case const (Row):
          {
            final list = array[index] as Row;
            data = _parseWidgetContainerLocation(
              list.children,
              activeTextFieldController,
              isFromRowOrColumn: true
            );
            if (_parsedData == null && data != null) {
              _parsedData = ParsedWidgetsData(wigetData: array);
            }
            isFromRowOrColumn = false;
            break;
          }
        case const (Column):
          {
            final list = array[index] as Column;
            data = _parseWidgetContainerLocation(
              list.children, 
              activeTextFieldController,
              isFromRowOrColumn: true
            );
            if (_parsedData == null && data != null) {
              _parsedData = ParsedWidgetsData(wigetData: array);
            }
            isFromRowOrColumn = false;
            break;
          }
        case const (TextField):
          {
            final textFieldWidget = array[index] as TextField;
            if (textFieldWidget.controller == activeTextFieldController) {
              return ParsedWidgetsData();
            }
            break;
          }
        case const (Stack):
          {
            final list = array[index] as Stack;
            data = _parseWidgetContainerLocation(
              list.children, 
              activeTextFieldController,
              isFromRowOrColumn: true
            );
            if (_parsedData == null && data != null) {
              data.index = index; 
              data.wigetData = array; 
              _parsedData = data; 
            }
            isFromRowOrColumn = false;
            break;
          }
        case const (SizedBox):
          {
            final widget = array[index] as SizedBox;
            if (widget.child != null) {
              data = _parseWidgetInContainer(
                widget.child!, 
                activeTextFieldController
              );
            }
            if (data != null && _parsedData == null) {
              data.index = index; 
              if (isFromRowOrColumn == false) {
                data.wigetData = array;
                _parsedData = data; 
              }
              return data;
            }
            break;
          }
        case const (Positioned):
          {
            final widget = array[index] as Positioned;
            data = _parseWidgetInContainer(
              widget.child, 
              activeTextFieldController
            ); 
            if (data != null && _parsedData == null) {
              if (isFromRowOrColumn == false) {
                data.wigetData = array;
                _parsedData = data; 
              }
              return data;
            }
            break;
          }
        case const (ArgumentWidget):
        {
          final widget = (array[index] as ArgumentWidget).child as Row; 
          data = _parseWidgetContainerLocation(
            widget.children,
            activeTextFieldController,
            isFromRowOrColumn: true
          );
          if (_parsedData == null && data != null) {
            _parsedData = ParsedWidgetsData(wigetData: array);
          }
          isFromRowOrColumn = false;
          break;
        }
        case const (TextFieldWidgetHandler):
        {
          final textFieldWidget = array[index] as TextFieldWidgetHandler;
          if (textFieldWidget.textField!.controller == activeTextFieldController) {
            return ParsedWidgetsData(wigetData: array, index: index);
          }
          break;
        }
        case const (RelayedPositioned): 
        {   
          final widget = array[index] as RelayedPositioned;
          data = _parseWidgetInContainer(
            widget.widgetToWrap, 
            activeTextFieldController
          );
          if (data != null && _parsedData == null) {
            data.index = index;
            if (isFromRowOrColumn == false) {
              data.wigetData = array;
              _parsedData = data;
            }
            return data;
          }
        }
        case const (WidgetDynamicSizeWrapper): 
        {
          final widget = array[index] as WidgetDynamicSizeWrapper;
          data = _parseWidgetInContainer(
            widget.wrappedWidget, 
            activeTextFieldController
          );
          if (data != null && _parsedData == null) {
            data.index = index;
            if (isFromRowOrColumn == false) {
              data.wigetData = array;
              _parsedData = data;
            }
            return data;
          }
        } 
      }
    }
    return null;
  }

  ParsedWidgetsData? _parseWidgetInContainer(
      Widget widget, TextEditingController activeTextFieldController) {
    ParsedWidgetsData? data;
    final widgetRunType = widget.runtimeType;
    switch (widgetRunType) {
      case const (RelayedPositioned): 
        {   
          final relayedPositioned = widget as RelayedPositioned; 
          data = _parseWidgetInContainer(relayedPositioned.widgetToWrap, activeTextFieldController);
          return data;
        } 
      case const (TextField):
        {
          final textFieldWidget = widget as TextField;
          if (textFieldWidget.controller == activeTextFieldController) {
            return ParsedWidgetsData();
          }
          break; 
        }
      case const (Column):
      {
        final column = widget as Column;
        data = _parseWidgetContainerLocation(
          column.children, 
          activeTextFieldController, 
          isFromRowOrColumn: true
        );
        return data;
      }
      case  const (Row):
      {
        final row = widget as Row;
        data = _parseWidgetContainerLocation(
          row.children, 
          activeTextFieldController,
          isFromRowOrColumn: true
        );
      return data;
      }
      case const (Stack):
      {
        final stack = widget as Stack;
        data = _parseWidgetContainerLocation(
          stack.children, 
          activeTextFieldController,
          isFromRowOrColumn: true
        );
        return data;
      }
      case const (Positioned):
      {
        widget as Positioned; 
        data = _parseWidgetInContainer(
          widget.child, 
          activeTextFieldController
        );
        return data;
      }
      case const (SizedBox):
      {
        widget as SizedBox;
        data = _parseWidgetInContainer(
          widget.child!, 
          activeTextFieldController
        );
        return data;
      }
      case const (ArgumentWidget):
      {
        final integralArg = widget as ArgumentWidget;
        data = _parseWidgetInContainer(integralArg.child!, activeTextFieldController);
        return data;  
      }
      case const (WidgetDynamicSizeWrapper): 
      {
        final widgetDynamicSizeWrapper = widget as WidgetDynamicSizeWrapper; 
        data = _parseWidgetInContainer(widgetDynamicSizeWrapper.wrappedWidget, activeTextFieldController);
        return data;
      }
      case const (TextFieldWidgetHandler):
      {
        final textFieldHandler = widget as TextFieldWidgetHandler; 
        data = _parseWidgetInContainer(textFieldHandler.textField!, activeTextFieldController);
        return data; 
      }
    }
    return null;
  }  
}

class ParsedWidgetsData {
  List<Widget>? wigetData;
  bool? isGroop;
  int? index;
  ParsedWidgetsData({this.wigetData, this.index, this.isGroop});
}
