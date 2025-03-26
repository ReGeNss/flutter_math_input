import 'package:flutter/material.dart';
import '../services/math_constructions_building.dart';
import '../services/text_field_handle_and_create.dart';

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
      if(array[index].isSingleChild){
        final widget = array[index];
        if (widget.singleChild != null) {
          data = _parseWidgetLocation(
            [widget.singleChild!],
            activeTextFieldController,
          );
          if (data != null) {
            data.index = index;
            data.wigetData = array;
            _parsedData ??= data;
          }        
        }
      }
      else if(array[index].isMultiChild){
        final widget = array[index];
        data = _parseWidgetLocation(
          widget.multiChild,
          activeTextFieldController
        );
        if (data != null) {
          return data;
        }
      }else if(array[index] is TextFieldWidgetHandler){
        final widget =
                (array[index] as TextFieldWidgetHandler).textField as TextField;
        data = _parseWidgetLocation(
          [widget],
          activeTextFieldController
        );
        if (data != null) {
          return data;
        }
      }else if(array[index] is TextField){
        final widget = array[index] as TextField;
        if(widget.controller == activeTextFieldController){
          return ParsedWidgetsData(wigetData: array, index: index);
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
      if(array[index].isSingleChild){
        final widget = array[index].singleChild;
        if (widget != null) {
          data = _parseWidgetInContainer(
            widget, 
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
      }else if(array[index].isMultiChild){
        final list = array[index].multiChild;
        data = _parseWidgetContainerLocation(
          list,
          activeTextFieldController,
          isFromRowOrColumn: true
        );
        if (_parsedData == null && data != null) {
          _parsedData = ParsedWidgetsData(wigetData: array);
        }
        isFromRowOrColumn = false;
      }else if(array[index] is TextFieldWidgetHandler){
        final textFieldWidget = array[index] as TextFieldWidgetHandler;
        if (textFieldWidget.textField!.controller == activeTextFieldController) {
          return ParsedWidgetsData(wigetData: array, index: index);
        }
      }
    }
    return null;
  }

  ParsedWidgetsData? _parseWidgetInContainer(
      Widget widget, TextEditingController activeTextFieldController) {
    ParsedWidgetsData? data;
    if(widget.isSingleChild){ 
      data = _parseWidgetInContainer(widget.singleChild!, activeTextFieldController);
      return data;
    }else if(widget.isMultiChild){
      data = _parseWidgetContainerLocation(
        widget.multiChild, 
        activeTextFieldController,
        isFromRowOrColumn: true,
      );
      return data;
    }else if(widget is TextFieldWidgetHandler){
      final textFieldWidget = widget.textField as TextField;
      if (textFieldWidget.controller == activeTextFieldController) {
        return ParsedWidgetsData();
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
