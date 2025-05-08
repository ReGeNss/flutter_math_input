import 'package:flutter/material.dart';
import '../../../../interfaces/index.dart';
import '../../../../math_constructions/index.dart';
import '../../custom_math_icons.dart';
import '../basis_keyboard.dart';

class FunctionPageWidget extends StatelessWidget {
  const FunctionPageWidget({
    required this.keyboardPaddings, 
    required this.keyboardSpacing,
    required this.keyboardProperties,
    this.iconSize = 30,
    this.buttonStyle, 
    this.textStyle, 
    super.key,
  });

  final double iconSize;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final double keyboardPaddings;
  final double keyboardSpacing;
  final MathController keyboardProperties;
  
  void addCharToTextField(String char) {
    keyboardProperties.addCharToTextField(char);
  }
  
  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> rows = [
      [
        FunctionButton(
          text:'cos',
          action: () => keyboardProperties.createDefaultFunc(Cos.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        FunctionButton(
          text: 'arccos',
          action: () => keyboardProperties.createDefaultFunc(Arccos.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        FunctionButton(
          text: 'lg',
          action: () => keyboardProperties.createDefaultFunc(LogBase10.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        KeyboardIconButton(
          icon: CustomMathIcons.abs, 
          action: () => keyboardProperties.createDefaultFunc(Abs.new),
          iconSize: iconSize,
        ),
        CharButton(
          text: '!',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: 'e',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
      ],
      [
        FunctionButton(
          text: 'sin',
          action: () => keyboardProperties.createDefaultFunc(Sin.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        FunctionButton(
          text: 'arcsin',
          action: () => keyboardProperties.createDefaultFunc(Arcsin.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        FunctionButton(
          text: 'log₂',
          action: () => keyboardProperties.createDefaultFunc(LogBase2.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        KeyboardIconButton(
          icon: CustomMathIcons.lim, 
          action: () => keyboardProperties.createDefaultFunc(Limit.new),
          iconSize: iconSize,
        ),
        CharButton(
          text: 'f(x)',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: '∞',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
      ],
      [
        FunctionButton(
          text: 'tan',
          action: () => keyboardProperties.createDefaultFunc(Tan.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        FunctionButton(
          text: 'arctan',
          action: () => keyboardProperties.createDefaultFunc(Arctan.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        KeyboardIconButton(
          icon: CustomMathIcons.log,
          action: () => keyboardProperties.createDefaultFunc(Log.new),
          iconSize: iconSize,
        ),
        KeyboardIconButton(
          icon: CustomMathIcons.integral, 
          action: () => keyboardProperties.createDefaultFunc(Integral.new),
          iconSize: iconSize,
        ),
        KeyboardIconButton(
          icon: CustomMathIcons.dx_dy, 
          action: () => keyboardProperties.createDefaultFunc(Derivative.new),
          iconSize: iconSize,
        ),
        EmptyButton(
          buttonStyle: buttonStyle,
        ),
      ],
      [
        FunctionButton(
          text: 'cot',
          action: () => keyboardProperties.createDefaultFunc(Cot.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        FunctionButton(
          text: 'arcctg',
          action: () => keyboardProperties.createDefaultFunc(Arccot.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        FunctionButton(
          text: 'ln',
          action: () => keyboardProperties.createDefaultFunc(NaturalLog.new),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        KeyboardIconButton(
          icon: CustomMathIcons.indefinite_integral, 
          action: () => keyboardProperties.createDefaultFunc(
            IndefiniteIntegral.new,
          ),
          iconSize: iconSize,
        ),
        KeyboardIconButton(
          icon: CustomMathIcons.derivative, 
          action: () => keyboardProperties.createDefaultFunc(
            EmptyDerivative.new,
          ),
          iconSize: iconSize,
        ),
        EmptyButton(
          buttonStyle: buttonStyle,
        ),
      ]
    ];

    return KeyboardPageWidget(
      pageRows: rows,
      keyboardPaddings: keyboardPaddings, 
      keyboardSpacing: keyboardSpacing,
    );
  }
}

class FunctionButton extends StatelessWidget {
  final String text;
  final VoidCallback action;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;

  const FunctionButton({
    required this.action,
    required this.text, 
    this.buttonStyle,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action,
      style: buttonStyle ?? defaultButtonStyle,
      child: Text(text, style: textStyle),
    );
  }
}

class CharButton extends StatelessWidget {
  final String text;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final Function(String) addCharToTextField;

  const CharButton({
    required this.text,
    required this.addCharToTextField,
    this.buttonStyle,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => addCharToTextField(text),
      style: buttonStyle ?? defaultButtonStyle,
      child: Text(text, style: textStyle),
    );
  }
}

class EmptyButton extends StatelessWidget {
  final ButtonStyle? buttonStyle;

  const EmptyButton({
    super.key,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: buttonStyle ?? defaultButtonStyle,
      child: const Text(''),
    );
  }
}

class KeyboardIconButton extends StatelessWidget {
  const KeyboardIconButton({
    required this.action,
    required this.icon,
    required this.iconSize,
    this.buttonStyle,
    this.color,
    super.key,
  });

  final VoidCallback action;
  final IconData icon;
  final double iconSize;
  final ButtonStyle? buttonStyle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action,
      style: buttonStyle ?? defaultButtonStyle,
      child: 
        Icon(icon, color: color ?? Colors.black, size: iconSize),
    );
  }
}
