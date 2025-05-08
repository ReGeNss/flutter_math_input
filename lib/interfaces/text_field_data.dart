import 'package:flutter/material.dart';

import '../services/index.dart';

class TextFieldData {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextFieldFormat format;

  TextFieldData({
    required this.controller,
    required this.format,
    required this.focusNode,
  });
}