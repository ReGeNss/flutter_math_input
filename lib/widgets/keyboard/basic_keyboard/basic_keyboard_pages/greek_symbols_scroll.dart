import 'package:flutter/material.dart';
import '../../../../interfaces/index.dart';
import '../basis_keyboard.dart';

const greekSymbolsList = [
    'α', 'β', 'γ', 'Δ', 'ε', 'η', 'θ', 'σ', 'τ', 'φ', 'ψ', 'ω',
  ];

class ScrollGreekSymbolsWidget extends StatelessWidget {
  const ScrollGreekSymbolsWidget({
    required this.keyboardSpacing,
    required this.keyboardProperties,
    required this.keyboardPadding,
    super.key,
    this.iconSize = 30,
    this.buttonStyle,
    this.textStyle,
  });
  
  final double iconSize;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  final double keyboardSpacing;
  final MathController keyboardProperties;
  final double keyboardPadding;

  @override
  Widget build(BuildContext context) {
    final buttonWidth = (
      MediaQuery.of(context).size.width 
      - keyboardPadding - keyboardSpacing 
      * (countOfButtonsInRow - 1)) 
      / countOfButtonsInRow;
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
        ),).toList(),
      ),
    ),);
  }
}
