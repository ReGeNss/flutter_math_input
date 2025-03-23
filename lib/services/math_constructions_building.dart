import 'package:flutter/material.dart';
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

ObjectKey getKey(ElementsType type){
  return ObjectKey(MathConstructionKey(type: type));
}

class MathConstructionKey{
  final ElementsType type;
  
  MathConstructionKey({required this.type,});
}

class MathConstructionData {
  final Widget? addictionalWidget;
  final Widget construction;

  MathConstructionData({required this.construction, this.addictionalWidget});
}

abstract class SingleChildConstruction{
  Widget? child;
}

abstract class MultiChildConstruction{
  List<Widget> children = [];
}
