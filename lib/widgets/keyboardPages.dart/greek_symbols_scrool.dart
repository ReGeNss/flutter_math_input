import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:provider/provider.dart';

const greekSymbolsList = ['α', 'β', 'γ', 'Δ', 'ε', 'η', 'θ', 'σ', 'τ', 'φ', 'ψ', 'ω'];

class ScroolGreekSymbolsWidget extends StatelessWidget {
  const ScroolGreekSymbolsWidget({
    super.key,
    this.iconSize = 30,
    this.buttonStyle,
    this.textStyle,
    required this.keyboardSpacing,
  });
  
  final double iconSize;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  final double keyboardSpacing;
  @override
  Widget build(BuildContext context) {
    final model = context.read<MathKeyboardModel>(); 
    return SizedBox(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: keyboardSpacing,
          children: greekSymbolsList.map((symbol) => SizedBox(
          width: 50,  
          height: double.infinity,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField(symbol);
            },
            style: buttonStyle ?? defaultButtonStyle,
            child: Text(symbol, style: textStyle),
          ),
        )).toList(),
      ),
    ));
  }
}