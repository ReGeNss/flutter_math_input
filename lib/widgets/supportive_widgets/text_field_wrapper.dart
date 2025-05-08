import 'package:flutter/material.dart';
import 'package:flutter_math_input/services/text_field_handle_and_create.dart';

import '../../interfaces/index.dart';

class TextFieldWrapper extends StatefulWidget {
  TextFieldWrapper({
    required this.textFieldData,
    required this.onTextFieldTap,
    super.key,
  });

  final TextFieldData textFieldData;
  final Function(TextFieldData textFieldControllerData) onTextFieldTap;
  TextField? textField;
  String? initTextInField;

  @override
  State<TextFieldWrapper> createState() => _TextFieldWrapperState();
}

class _TextFieldWrapperState extends State<TextFieldWrapper> {
  @override
  Widget build(BuildContext context) {
    if (widget.textField == null) {
      widget.textField = TextField(
        textAlign: TextAlign.left,
        focusNode: widget.textFieldData.focusNode,
        style: const TextStyle(fontSize: 20),
        keyboardType: TextInputType.none,
        decoration: textFieldDecoration,
        controller: widget.textFieldData.controller,
        onChanged: (_) => setState((){}),
        onTap: () {
          widget.onTextFieldTap(widget.textFieldData);
        },
      );
      if (widget.initTextInField != null) {
        widget.textFieldData.controller.text = widget.initTextInField!;
      }
    }
    final fieldWidget = IntrinsicWidth(
      child: widget.textField,
    );
    
    return fieldWidget;
  }
}