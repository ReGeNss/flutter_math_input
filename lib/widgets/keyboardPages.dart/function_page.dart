import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/widgets/keyboard.dart';

class FunctionPageWidget extends StatelessWidget {
  const FunctionPageWidget({
    super.key,
    this.iconSize = 30,
    this.buttonStyle, 
    this.textStyle, 
    required this.keyboardPaddings, 
    required this.keyboardSpacing,
    required this.keyboardProperties,
  });

  final double iconSize;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final double keyboardPaddings;
  final double keyboardSpacing;
  final MathKontroller keyboardProperties;

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> rows = [
      [
        _buildFunctionButton('cos', ElementsType.cosElement),
        _buildFunctionButton('arccos', ElementsType.arccosElement),
        _buildFunctionButton('lg', ElementsType.decimalLogElement),
        _buildIconButton(CustomMathIcons.abs, keyboardProperties.absButtonTap),
        _buildTextButton('!'),
        _buildTextButton('e'),
      ],
      [
        _buildFunctionButton('sin', ElementsType.sinElement),
        _buildFunctionButton('arcsin', ElementsType.arcsinElement),
        _buildFunctionButton('log₂', ElementsType.logBaseTwoElement),
        _buildIconButton(CustomMathIcons.lim, keyboardProperties.limButtonTap),
        _buildTextButton('f(x)'),
        _buildTextButton('∞'),
      ],
      [
        _buildFunctionButton('tan', ElementsType.tanElement),
        _buildFunctionButton('arctan', ElementsType.arctanElement),
        _buildIconButton(CustomMathIcons.log, keyboardProperties.logButtonTap),
        _buildIconButton(CustomMathIcons.integral, keyboardProperties.integralButtonTap),
        _buildIconButton(
          CustomMathIcons.dx_dy, 
          () => keyboardProperties.onDerevativeButtonTap(upperField: 'x', downField: 'y')
        ),
        _buildEmptyButton(),
      ],
      [
        _buildFunctionButton('cot', ElementsType.cotElement),
        _buildFunctionButton('arcctg', ElementsType.arccotElement),
        _buildFunctionButton('ln', ElementsType.naturalLogElement),
        _buildIconButton(
          CustomMathIcons.indefinite_integral, 
          keyboardProperties.undefinitintegralButtonTap
        ),
        _buildIconButton(CustomMathIcons.derevative, keyboardProperties.onDerevativeButtonTap),
        _buildEmptyButton(),
      ]
    ];
    return KeyboardPageWidget(
      pageRows: rows,
      keyboardPaddings: keyboardPaddings, 
      keyboardSpacing: keyboardSpacing
    );
  }

  Widget _buildFunctionButton(String text, ElementsType type) {
    return TextButton(
      onPressed: () => keyboardProperties.namedFunctionButtonTap(text, type),
      style: buttonStyle ?? defaultButtonStyle,
      child: Text(text, style: textStyle)
    );
  }

  Widget _buildTextButton(String text) {
    return TextButton(
      onPressed: () => keyboardProperties.addCharToTextField(text),
      style: buttonStyle ?? defaultButtonStyle,
      child: Text(text, style: textStyle)
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: buttonStyle ?? defaultButtonStyle,
      child: Icon(icon, color: (textStyle?.color) ?? Colors.black, size: iconSize)
    );
  }

  Widget _buildEmptyButton() {
    return TextButton(
      onPressed: () {},
      style: buttonStyle ?? defaultButtonStyle,
      child: Text('', style: textStyle)
    );
  }
}