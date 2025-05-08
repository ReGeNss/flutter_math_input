import 'package:flutter/material.dart';
import 'text_field_handle_and_create.dart';

class MathConstructionsBuilder {
  final TextFieldHandleAndCreateService _textFieldService;

  MathConstructionsBuilder({
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
