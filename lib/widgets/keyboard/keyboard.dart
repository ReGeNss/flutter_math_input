import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../interfaces/index.dart';

abstract class MathKeyboard {
  final BuildContext context;
  late final MathController keyboardProperties;
  
  MathKeyboard({required this.context}){
    try{
      keyboardProperties = context.read<MathController>();
    } on ProviderNotFoundException {
      throw Exception(
        'MathController not found.'
        'Please add provide MathController to your widget tree.'
      );
    }
  }

  Widget buildKeyboard(StateSetter setState);

  void show() {
    try{
      Scaffold.of(context).showBottomSheet(
        (context) => StatefulBuilder(
          builder: (context, setState) => buildKeyboard(setState),
        ),
      );
    } catch (e) {
      throw Exception(
        'Something went wrong.'
        'Tap delete button to clear the input'
      );
    }
  }
}
