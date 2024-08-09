import 'package:flutter/material.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

class MathConstructionsBuilding{
  final TextFieldHandleAndCreateService textFiledService;

  MathConstructionsBuilding({required this.textFiledService}); 
  void createTextField(){
    final textField = textFiledService.createTextField();

  }

  Widget initialization(){
    final textField = textFiledService.createTextField();
    return textField; 
  }
}