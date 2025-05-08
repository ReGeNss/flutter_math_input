// ignore_for_file: require_trailing_commas
import 'package:flutter/material.dart';
import 'package:flutter_math_input/widgets/keyboard/basic_keyboard/basic_keyboard_pages/function_page.dart';
import '../../../../flutter_math_input.dart';
import '../../../../interfaces/index.dart';
import '../../../../math_constructions/index.dart';
import '../float_button_overlay.dart';

class NumbersPageWidget extends StatelessWidget {
  const NumbersPageWidget({
    required this.keyboardPaddings,
    required this.keyboardSpacing,
    required this.keyboardProperties,
    required this.floatButtonOverlayDuration,
    this.iconSize = 30,
    this.buttonStyle,
    this.buttonWithOverlayStyle,
    this.textStyle,
    this.overlayButtonStyle,
    super.key,
  });
  final double iconSize;
  final TextStyle? textStyle; 
  final ButtonStyle? buttonStyle;
  final ButtonStyle? buttonWithOverlayStyle;
  final ButtonStyle? overlayButtonStyle;
  final double keyboardPaddings;
  final double keyboardSpacing;
  final MathController keyboardProperties;
  final int floatButtonOverlayDuration;

  void addCharToTextField(String char) {
    keyboardProperties.addCharToTextField(char);
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = (
      MediaQuery.of(context).size.width - 
      keyboardPaddings - 
      keyboardSpacing * 
      (countOfButtonsInRow - 1)) /
      countOfButtonsInRow;

    final List<List<Widget>> rows = [
      [
        TextButton(
            onPressed: () => keyboardProperties.createDefaultFunc(Brackets.new),
            onLongPress: () {
              FloatButtonOverlay().createOverlay(
                context, 
                floatButtonOverlayDuration: floatButtonOverlayDuration,
                keyboardSpacing: keyboardSpacing, 
                keyboardPaddings: keyboardPaddings,
                buttonWidth: buttonWidth,
                buttonsData: [
                  FloatButtonData(
                    buttonFunction: () {
                      keyboardProperties.addCharToTextField('(');
                    },
                    buttonWidget: Text('(', style: textStyle),
                    buttonStyle: overlayButtonStyle ?? defaultOverlayButtonStyle
                  ),
                  FloatButtonData(
                    buttonFunction: () {
                      keyboardProperties.addCharToTextField(')');
                    },
                    buttonWidget: Text(')', style: textStyle),
                    buttonStyle: overlayButtonStyle ?? defaultOverlayButtonStyle
                  )
              ]);
            },
            style: buttonWithOverlayStyle ?? defaultButtonWithOverlayStyle,
            child: Text('( )', style: textStyle)),
        TextButton(
          onPressed: () {
            FloatButtonOverlay().createOverlay(
              context,
              floatButtonOverlayDuration: floatButtonOverlayDuration,
              buttonWidth: buttonWidth,
              keyboardSpacing: keyboardSpacing, 
              keyboardPaddings: keyboardPaddings,
              buttonsData: [
              FloatButtonData(
                  buttonFunction: () {
                    keyboardProperties.addCharToTextField('>');
                  },
                  buttonWidget: Text('>', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defaultOverlayButtonStyle),
              FloatButtonData(
                  buttonFunction: () {
                    keyboardProperties.addCharToTextField('<');
                  },
                  buttonWidget: Text('<', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defaultOverlayButtonStyle),
              FloatButtonData(
                  buttonFunction: () {
                    keyboardProperties.addCharToTextField('≥');
                  },
                  buttonWidget: Text('≥', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defaultOverlayButtonStyle),
              FloatButtonData(
                  buttonFunction: () {
                    keyboardProperties.addCharToTextField('≤');
                  },  
                  buttonWidget: Text('≤', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defaultOverlayButtonStyle)
            ]);
          },
          onLongPress: () {
            FloatButtonOverlay().createOverlay(
              context, 
              floatButtonOverlayDuration: floatButtonOverlayDuration,
              buttonWidth: buttonWidth,
              keyboardSpacing: keyboardSpacing, 
              keyboardPaddings: keyboardPaddings,
              buttonsData: [
                FloatButtonData(
                  buttonFunction: () {
                    keyboardProperties.addCharToTextField('>');
                  },
                  buttonWidget: Text('>', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defaultOverlayButtonStyle
                ),
                FloatButtonData(
                  buttonFunction: () {
                    keyboardProperties.addCharToTextField('<');
                  },
                  buttonWidget: Text('<', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defaultOverlayButtonStyle
                ),
                FloatButtonData(
                  buttonFunction: () {
                    keyboardProperties.addCharToTextField('≥');
                  },
                  buttonWidget: Text('≥', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defaultOverlayButtonStyle
                ),
                FloatButtonData(
                  buttonFunction: () {
                    keyboardProperties.addCharToTextField('≤');
                  },
                  buttonWidget: Text('≤', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defaultOverlayButtonStyle
                )
            ]);
          },
          style: buttonWithOverlayStyle ?? defaultButtonWithOverlayStyle,
          child: Text('>,<', style: textStyle),
        ),
        CharButton(
          text: '7',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: '8',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: '9',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        FunctionButton(
          text: '÷',
          action: () => keyboardProperties.createCharWidgets('÷'),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
      ],
      [
        KeyboardIconButton(
          icon: CustomMathIcons.frac,
          action: () => keyboardProperties.createDefaultFunc(Frac.new),
          iconSize: iconSize,
        ),
        KeyboardIconButton(
          icon: CustomMathIcons.sqrt,
          action: () => keyboardProperties.createDefaultFunc(Sqrt.new),
          iconSize: iconSize,
        ),
        CharButton(
          text: '4',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: '5',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: '6',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        FunctionButton(
          text: '×',
          action: () => keyboardProperties.createCharWidgets('×'),
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
      ],
      [
        KeyboardIconButton(
          icon: CustomMathIcons.exp,
          action: () => keyboardProperties.createComplicatedFunc(Exp.new),
          iconSize: iconSize,
        ),
        CharButton(
          text: 'x',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: '1',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: '2',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: '3',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        FunctionButton(
          text: '-',
          action: () => keyboardProperties.createCharWidgets('-'), 
          textStyle: textStyle,
          buttonStyle: buttonStyle,
        ),
      ],
      [
        CharButton(
          text: 'π',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: '%',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: '0',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        CharButton(
          text: ',',
          addCharToTextField: addCharToTextField,
          buttonStyle: buttonStyle,
          textStyle: textStyle,
        ),
        Builder(builder: (context) {
          return TextButton(
              onLongPress: () {
                FloatButtonOverlay().createOverlay(
                  context, 
                  floatButtonOverlayDuration: floatButtonOverlayDuration,
                  buttonWidth: buttonWidth,
                  keyboardSpacing: keyboardSpacing, 
                  keyboardPaddings: keyboardPaddings,
                  buttonsData: [
                    FloatButtonData(
                      buttonFunction: () {
                        keyboardProperties.createCharWidgets('≠');
                      },
                      buttonWidget: Text('≠', style: textStyle)
                    )
                ]);
              },
              onPressed: () {
                keyboardProperties.createCharWidgets('=');
              },
              style: buttonWithOverlayStyle ?? defaultButtonWithOverlayStyle,
              child: Text('=', style: textStyle));
        }),
        Builder(builder: (context) {
          return TextButton(
              onLongPress: () {
                FloatButtonOverlay().createOverlay(
                  context, 
                  floatButtonOverlayDuration: floatButtonOverlayDuration,
                  buttonWidth: buttonWidth,
                  keyboardSpacing: keyboardSpacing, 
                  keyboardPaddings: keyboardPaddings,
                  buttonsData: [
                    FloatButtonData(
                      buttonFunction: () {
                        keyboardProperties.createCharWidgets('±');
                      },
                      buttonWidget: Text('±', style: textStyle)
                    )
                ]);
              },
              onPressed: () {
                keyboardProperties.createCharWidgets('+');
              },
              style: buttonWithOverlayStyle ?? defaultButtonWithOverlayStyle,
              child: Text('+', style: textStyle));
        }),
      ],
    ]; 
    
    return KeyboardPageWidget(
      pageRows: rows, 
      keyboardPaddings: keyboardPaddings, 
      keyboardSpacing: keyboardSpacing
    );
  }
}
