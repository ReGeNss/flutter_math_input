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
        _buildFunctionButton(
          'cos',
          () => keyboardProperties.createDefaultFunc(Cos.new)
        ),
        _buildFunctionButton(
          'arccos',
          () => keyboardProperties.createDefaultFunc(Arccos.new)
        ),
        _buildFunctionButton(
          'lg',
          () => keyboardProperties.createDefaultFunc(LogBase10.new)
        ),
        _buildIconButton(
          CustomMathIcons.abs, 
          () => keyboardProperties.createDefaultFunc(Abs.new)
        ),
        _buildTextButton('!'),
        _buildTextButton('e'),
      ],
      [
        _buildFunctionButton(
          'sin',
          () => keyboardProperties.createDefaultFunc(Sin.new)
        ),
        _buildFunctionButton(
          'arcsin',
          () => keyboardProperties.createDefaultFunc(Arcsin.new)
        ),
        _buildFunctionButton(
          'log₂',
          () => keyboardProperties.createDefaultFunc(LogBase2.new)
        ),
        _buildIconButton(CustomMathIcons.lim, () => keyboardProperties.createDefaultFunc(Limit.new)),
        _buildTextButton('f(x)'),
        _buildTextButton('∞'),
      ],
      [
        _buildFunctionButton(
          'tan',
          () => keyboardProperties.createDefaultFunc(Tan.new)
        ),
        _buildFunctionButton(
          'arctan',
          () => keyboardProperties.createDefaultFunc(Arctan.new)
        ),
        _buildIconButton(CustomMathIcons.log, () => keyboardProperties.createDefaultFunc(Log.new)),
        _buildIconButton(CustomMathIcons.integral, () => keyboardProperties.createDefaultFunc(Integral.new)),
        _buildIconButton(
          CustomMathIcons.dx_dy, 
          () => keyboardProperties.createDefaultFunc(Derivative.new)
        ),
        _buildEmptyButton(),
      ],
      [
        _buildFunctionButton(
          'cot',
          () => keyboardProperties.createDefaultFunc(Cot.new)
        ),
        _buildFunctionButton(
          'arcctg',
          () => keyboardProperties.createDefaultFunc(Arccot.new)
        ),
        _buildFunctionButton(
          'ln',
          () => keyboardProperties.createDefaultFunc(NaturalLog.new)
        ),
        _buildIconButton(
          CustomMathIcons.indefinite_integral, 
          () => keyboardProperties.createDefaultFunc(UndefinitIntegral.new)
        ),
        _buildIconButton(
          CustomMathIcons.derevative, 
          () => keyboardProperties.createDefaultFunc(EmptyDerevative.new)
        ),
        _buildEmptyButton(),
      ]
    ];
    return KeyboardPageWidget(
      pageRows: rows,
      keyboardPaddings: keyboardPaddings, 
      keyboardSpacing: keyboardSpacing
    );
  }

  Widget _buildFunctionButton(String text, VoidCallback action){
    return TextButton(
      onPressed: action,
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

  Widget _buildIconButton(IconData icon, VoidCallback action) {
    return TextButton(
      onPressed: action,
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