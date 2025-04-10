import 'package:flutter/material.dart';
import 'text_field_handle_and_create.dart';

class MathConstructionsBuilding {
  final TextFieldHandleAndCreateService _textFieldService;

  MathConstructionsBuilding({
    required TextFieldHandleAndCreateService textFieldService,
  }) : _textFieldService = textFieldService;

  Widget createTextField({
    bool replaceOldFocus = false,
    bool isActive = false, 
    TextFieldFormat? format,
    bool performAdditionalTextField = false,
    }) {  
    final textField = _textFieldService.createTextField(
      isReplaceOperation: replaceOldFocus, 
      isActiveTextField: isActive,
      selectedTextFieldFormat: format,
      performAdditionalTextField: performAdditionalTextField,
    );

    return textField;
  }

  Widget createCharWidget({required bool isActiveTextField}) {
    final textFieldWidget = _textFieldService.createTextField(
        isActiveTextField: isActiveTextField, isReplaceOperation: false,);

    return textFieldWidget;
  }

  void markAsGroup(dynamic first, Widget second) {
    _textFieldService.markAsGroup(first, second);
  }

  Widget initialization() {
    final textField = _textFieldService.createTextField(
      isReplaceOperation: false,
      isActiveTextField: true,
      selectedTextFieldFormat: TextFieldFormat.standard,
      );

    return textField;
  }
}



extension ChildExtension on Widget{
  bool get isSingleChild{
    if(
      this is SingleChildRenderObjectWidget || 
      this is SingleChildConstruction || 
      this is ParentDataWidget
    ){
      return true; 
    }
    return false;
  }

  bool get isMultiChild{
    if(this is MultiChildRenderObjectWidget || this is MultiChildConstruction){
      return true;
    } 

    return false;
  }

  Widget? get singleChild{
    if(this is SingleChildRenderObjectWidget){
      return (this as SingleChildRenderObjectWidget).child;
    }
    if(this is SingleChildConstruction){
      return (this as SingleChildConstruction).child;
    }
    if(this is ParentDataWidget){
      return (this as ParentDataWidget).child;
    }

    return null;
  }

  List<Widget> get multiChild{
    if(this is MultiChildRenderObjectWidget){
      return (this as MultiChildRenderObjectWidget).children;
    }
    if(this is MultiChildConstruction){
      return (this as MultiChildConstruction).children;
    }
    return [];
  }
}

abstract class SingleChildConstruction{
  Widget? child;
}

abstract class MultiChildConstruction{
  List<Widget> children = [];
}
