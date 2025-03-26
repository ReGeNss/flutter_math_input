import 'package:flutter/material.dart';
import '../../../../../keyboard_controller.dart';
import '../../../../math_constructions/index.dart';
import '../../custom_math_icons_icons.dart';
import '../basic_keyboard.dart';

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
  final MathController keyboardProperties;

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> rows = [
      [
        _buildFunctionButton('cos', CosConstruction()),
        _buildFunctionButton('arccos', ArccosConstruction()),
        _buildFunctionButton('lg', LogBase10Construction()),
        _buildIconButton(CustomMathIcons.abs, keyboardProperties.absButtonTap),
        _buildTextButton('!'),
        _buildTextButton('e'),
      ],
      [
        _buildFunctionButton('sin', SinConstruction()),
        _buildFunctionButton('arcsin', ArcsinConstruction()),
        _buildFunctionButton('log₂', LogBase2Construction()),
        _buildIconButton(CustomMathIcons.lim, keyboardProperties.limButtonTap),
        _buildTextButton('f(x)'),
        _buildTextButton('∞'),
      ],
      [
        _buildFunctionButton('tan', TanConstruction()),
        _buildFunctionButton('arctan', ArctanConstruction()),
        _buildIconButton(CustomMathIcons.log, keyboardProperties.logButtonTap),
        _buildIconButton(CustomMathIcons.integral, keyboardProperties.integralButtonTap),
        _buildIconButton(
          CustomMathIcons.dx_dy, 
          () => keyboardProperties.onDerevativeButtonTap(upperField: 'x', downField: 'y')
        ),
        _buildEmptyButton(),
      ],
      [
        _buildFunctionButton('cot', CotConstruction()),
        _buildFunctionButton('arcctg', ArccotConstruction()),
        _buildFunctionButton('ln', NaturalLogConstruction()),
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

  Widget _buildFunctionButton(String text, MathConstruction type) {
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