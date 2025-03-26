import 'package:flutter/material.dart';
import '../math_constructions/index.dart';
import 'text_field_handle_and_create.dart';

enum ElementsType {
  fracElement,
  sqrtElement,
  fieldElement,
  exponentiationElement,
  naturalLogElement,
  decimalLogElement,
  logBaseTwoElement,
  logElement,
  absElement,
  limitElement,
  cosElement,
  sinElement,
  tanElement,
  cotElement,
  arcsinElement,
  arccosElement,
  arctanElement,
  arccotElement,
  indefiniteIntegralElement,
  integralElement,
  derevativeElement,
  backetsWidget,
}

class MathConstructionsBuilding {
  final TextFieldHandleAndCreateService textFieldService;

  MathConstructionsBuilding({required this.textFieldService});

  MathConstructionData createTextField({bool replaceOldFocus = false, TextFieldFormat? format}) {  
    final textField = textFieldService.createTextField(
      isReplaceOperation: replaceOldFocus, 
      isActiveTextField: true,
      selectedTextFieldFormat: format,
    );
    return MathConstructionData(construction: textField);
  }

  Widget createCharWidget({required bool isActiveTextField}) {
    final textFieldWidget = textFieldService.createTextField(
        isActiveTextField: isActiveTextField, isReplaceOperation: false);
    return textFieldWidget;
  }

  Widget initialization() {
    final textField = textFieldService.createTextField(
        isReplaceOperation: false,
        isActiveTextField: true,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.standart);
    return textField;
  }
}

ObjectKey getKey(MathConstruction constuction){
  return ObjectKey(MathConstructionKey(construction: constuction));
}

class MathConstructionKey{
  final MathConstruction construction;
  
  MathConstructionKey({required this.construction,});
}

class MathConstructionData {
  final Widget? addictionalWidget;
  final Widget construction;

  MathConstructionData({required this.construction, this.addictionalWidget});
}

extension ChildExtension on Widget{
  bool get isSingleChild{
    if(this is SingleChildRenderObjectWidget || this is SingleChildConstruction || this is ParentDataWidget){
      return true; 
    }
    return false;
  }

  bool get isMultiChildWidget{
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