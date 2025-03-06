import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/float_button_overlay.dart';
import 'package:math_keyboard/widgets/keyboard.dart';

class NumbersPageWidget extends StatelessWidget {
  const NumbersPageWidget({
    super.key,
    this.iconSize = 30,
    this.buttonStyle,
    this.buttonWithOverlayStyle,
    this.textStyle,
    this.overlayButtonStyle,
    required this.keyboardPaddings,
    required this.keyboardSpacing,
    required this.keyboardProperties,
    required this.floatButtonOverlayDuration,
  });
  final double iconSize;
  final TextStyle? textStyle; 
  final ButtonStyle? buttonStyle;
  final ButtonStyle? buttonWithOverlayStyle;
  final ButtonStyle? overlayButtonStyle;
  final double keyboardPaddings;
  final double keyboardSpacing;
  final MathKeyboardModel keyboardProperties;
  final int floatButtonOverlayDuration;

  @override
  Widget build(BuildContext context) {
    final buttonWidth = (MediaQuery.of(context).size.width - keyboardPaddings - keyboardSpacing * (countOfButtonsInRow - 1)) / countOfButtonsInRow;
    final List<List<Widget>> rows = [
      [
        TextButton(
            onPressed: () {
              keyboardProperties.backetsButtonTap();
            },
            onLongPress: () {
              FloatButtonOverlay().createOverlay(
                context, 
                floatButtonOverlayDuration: floatButtonOverlayDuration,
                keyboardSpacing: keyboardSpacing, 
                keyboardPaddings: keyboardPaddings,
                buttonWidth: buttonWidth,
                buttonsData: [
                  FloatButtonData(
                      buttonFuction: () {
                        keyboardProperties.addCharToTextField('(');
                      },
                      buttonWidget: Text('(', style: textStyle),
                      buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle
                    ),
                  FloatButtonData(
                      buttonFuction: () {
                        keyboardProperties.addCharToTextField(')');
                      },
                      buttonWidget: Text(')', style: textStyle),
                      buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle
                    )
              ]);
            },
            style: buttonWithOverlayStyle ?? defalutButtonWithOverlayStyle,
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
                  buttonFuction: () {
                    keyboardProperties.addCharToTextField('>');
                  },
                  buttonWidget: Text('>', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
              FloatButtonData(
                  buttonFuction: () {
                    keyboardProperties.addCharToTextField('<');
                  },
                  buttonWidget: Text('<', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
              FloatButtonData(
                  buttonFuction: () {
                    keyboardProperties.addCharToTextField('≥');
                  },
                  buttonWidget: Text('≥', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
              FloatButtonData(
                  buttonFuction: () {
                    keyboardProperties.addCharToTextField('≤');
                  },  
                  buttonWidget: Text('≤', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle)
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
                    buttonFuction: () {
                      keyboardProperties.addCharToTextField('>');
                    },
                    buttonWidget: Text('>', style: textStyle),
                    buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
                FloatButtonData(
                    buttonFuction: () {
                      keyboardProperties.addCharToTextField('<');
                    },
                    buttonWidget: Text('<', style: textStyle),
                    buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
                FloatButtonData(
                    buttonFuction: () {
                      keyboardProperties.addCharToTextField('≥');
                    },
                    buttonWidget: Text('≥', style: textStyle),
                    buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
                FloatButtonData(
                    buttonFuction: () {
                      keyboardProperties.addCharToTextField('≤');
                    },
                    buttonWidget: Text('≤', style: textStyle),
                    buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle)
            ]);
          },
          style: buttonWithOverlayStyle ?? defalutButtonWithOverlayStyle,
          child: Text('>,<', style: textStyle),
        ),
        _buildCharButton('7'),
        _buildCharButton('8'),
        _buildCharButton('9'),
        _createFunctionButtonWithText(() => keyboardProperties.createCharWidgets('÷'), '÷'),
      ],
      [
        _createFunctionButtonWithIcon(keyboardProperties.onFracButtonTap, CustomMathIcons.frac),
        _createFunctionButtonWithIcon(keyboardProperties.sqrtButtonTap, CustomMathIcons.sqrt),
        _buildCharButton('4'),
        _buildCharButton('5'),
        _buildCharButton('6'),
        _createFunctionButtonWithText(() => keyboardProperties.createCharWidgets('×'), '×'),
      ],
      [
        _createFunctionButtonWithIcon(keyboardProperties.onExpButtonTap, CustomMathIcons.exp),
        _buildCharButton('x'),
        _buildCharButton('1'),
        _buildCharButton('2'),
        _buildCharButton('3'),
        _createFunctionButtonWithText(() => keyboardProperties.createCharWidgets('-'), '-'),
      ],
      [
        _buildCharButton('π'),
        _buildCharButton('%'),
        _buildCharButton('0'),
        _buildCharButton(','),
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
                        buttonFuction: () {
                          keyboardProperties.createCharWidgets('≠');
                        },
                        buttonWidget: Text('≠', style: textStyle))
                ]);
              },
              onPressed: () {
                keyboardProperties.createCharWidgets('=');
              },
              style: buttonWithOverlayStyle ?? defalutButtonWithOverlayStyle,
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
                        buttonFuction: () {
                          keyboardProperties.createCharWidgets('±');
                      },
                      buttonWidget: Text('±', style: textStyle))
                ]);
              },
              onPressed: () {
                keyboardProperties.createCharWidgets('+');
              },
              style: buttonWithOverlayStyle ?? defalutButtonWithOverlayStyle,
              child: Text('+', style: textStyle));
        }),
      ],
    ]; 
    
    return KeyboardPageWidget(pageRows: rows, keyboardPaddings: keyboardPaddings, keyboardSpacing: keyboardSpacing);
  }

  TextButton _buildCharButton(String char){
    return TextButton(
      onPressed: () => keyboardProperties.addCharToTextField(char),
      style: buttonStyle ?? defaultButtonStyle,
      child: Text(char, style: textStyle)
    );
  }

  TextButton _createFunctionButtonWithIcon(Function function, IconData icon ){
    return TextButton(
      onPressed: () => function(),
      style: buttonStyle ?? defaultButtonStyle,
      child: Icon(icon, color: (textStyle?.color) ?? Colors.black, size: iconSize)
    );
  }

  TextButton _createFunctionButtonWithText(Function function, String text ){
    return TextButton(
      onPressed: () => function(),
      style: buttonStyle ?? defaultButtonStyle,
      child: Text(text, style: textStyle)
    );
  }
}
