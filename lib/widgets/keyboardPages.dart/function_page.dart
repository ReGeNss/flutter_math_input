import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:provider/provider.dart';

class FunctionPageWidget extends StatelessWidget {
  const FunctionPageWidget({
    super.key,
    this.iconSize = 30,
    this.buttonStyle, 
    this.textStyle, 
    required this.keyboardPaddings, 
    required this.keyboardSpacing,
  });

  final double iconSize;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final double keyboardPaddings;
  final double keyboardSpacing;

  @override
  Widget build(BuildContext context) {
    final model = context.read<MathKeyboardModel>();
    final List<List<Widget>> rows = [
      [
        _buildFunctionButton('cos', ElementsType.cosElement, model),
        _buildFunctionButton('arccos', ElementsType.arccosElement, model),
        _buildFunctionButton('lg', ElementsType.decimalLogElement, model),
        _buildIconButton(CustomMathIcons.abs, model.absButtonTap),
        _buildTextButton('!', model),
        _buildTextButton('e', model),
      ],
      [
        _buildFunctionButton('sin', ElementsType.sinElement, model),
        _buildFunctionButton('arcsin', ElementsType.arcsinElement, model),
        _buildFunctionButton('log₂', ElementsType.logBaseTwoElement, model),
        _buildIconButton(CustomMathIcons.lim, model.limButtonTap),
        _buildTextButton('f(x)', model),
        _buildTextButton('∞', model),
      ],
      [
        _buildFunctionButton('tan', ElementsType.tanElement, model),
        _buildFunctionButton('arctan', ElementsType.arctanElement, model),
        _buildIconButton(CustomMathIcons.log, model.logButtonTap),
        _buildIconButton(CustomMathIcons.integral, model.integralButtonTap),
        _buildIconButton(
          CustomMathIcons.dx_dy, 
          () => model.onDerevativeButtonTap(upperField: 'x', downField: 'y')
        ),
        _buildEmptyButton(),
      ],
      [
        _buildFunctionButton('cot', ElementsType.cotElement, model),
        _buildFunctionButton('arcctg', ElementsType.arccotElement, model),
        _buildFunctionButton('ln', ElementsType.naturalLogElement, model),
        _buildIconButton(
          CustomMathIcons.indefinite_integral, 
          model.undefinitintegralButtonTap
        ),
        _buildIconButton(CustomMathIcons.derevative, model.onDerevativeButtonTap),
        _buildEmptyButton(),
      ]
    ];
    return KeyboardPageWidget(
      pageRows: rows,
      keyboardPaddings: keyboardPaddings, 
      keyboardSpacing: keyboardSpacing
    );
  }

  Widget _buildFunctionButton(String text, ElementsType type, MathKeyboardModel model) {
    return TextButton(
      onPressed: () => model.namedFunctionButtonTap(text, type),
      style: buttonStyle ?? defaultButtonStyle,
      child: Text(text, style: textStyle)
    );
  }

  Widget _buildTextButton(String text, MathKeyboardModel model) {
    return TextButton(
      onPressed: () => model.addCharToTextField(text),
      style: buttonStyle ?? defaultButtonStyle,
      child: Text(text, style: textStyle)
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: buttonStyle ?? defaultButtonStyle,
      child: Icon(icon, color: textStyle?.color, size: iconSize)
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