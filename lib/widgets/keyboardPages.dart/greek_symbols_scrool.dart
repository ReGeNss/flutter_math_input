import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';

const greekSymbolsList = ['α', 'β', 'γ', 'Δ', 'ε', 'η', 'θ', 'σ', 'τ', 'φ', 'ψ', 'ω'];

class ScroolGreekSymbolsWidget extends StatelessWidget {
  const ScroolGreekSymbolsWidget({
    super.key,
    this.iconSize = 30,
    this.buttonStyle,
    this.textStyle,
    required this.keyboardSpacing,
    required this.keyboardProperties,
    required this.keyboardPadding,
  });
  
  final double iconSize;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  final double keyboardSpacing;
  final MathKeyboardModel keyboardProperties;
  final double keyboardPadding;

  @override
  Widget build(BuildContext context) {
    final buttonWidth = (MediaQuery.of(context).size.width - keyboardPadding - keyboardSpacing * (countOfButtonsInRow - 1)) / countOfButtonsInRow;
    return SizedBox(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: keyboardSpacing,
          children: greekSymbolsList.map((symbol) => SizedBox(
          width: buttonWidth,  
          height: double.infinity,
          child: TextButton(
            onPressed: () {
              keyboardProperties.addCharToTextField(symbol);
            },
            style: buttonStyle ?? defaultButtonStyle,
            child: Text(symbol, style: textStyle),
          ),
        )).toList(),
      ),
    ));
  }
}