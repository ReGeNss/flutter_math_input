import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:provider/provider.dart';


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
  });
  final double iconSize;
  final TextStyle? textStyle; 
  final ButtonStyle? buttonStyle;
  final ButtonStyle? buttonWithOverlayStyle;
  final ButtonStyle? overlayButtonStyle;
  final double keyboardPaddings;
  final double keyboardSpacing;



  @override
  Widget build(BuildContext context) {
    final model = context.read<MathKeyboardModel>();
    final List<List<Widget>> rows = [
      [
        TextButton(
            onPressed: () {
              model.backetsButtonTap();
            },
            onLongPress: () {
              FloatButtonOverlay().createOverlay(context, buttonsData: [
                FloatButtonData(
                    buttonFuction: () {
                      model.addCharToTextField('(');
                    },
                    buttonWidget: Text('(', style: textStyle),
                    buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
                FloatButtonData(
                    buttonFuction: () {
                      model.addCharToTextField(')');
                    },
                    buttonWidget: Text(')', style: textStyle),
                    buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle)
              ]);
            },
            style: buttonWithOverlayStyle ?? defalutButtonWithOverlayStyle,
            child: Text('( )', style: textStyle)),
        TextButton(
          onPressed: () {
            FloatButtonOverlay().createOverlay(context, buttonsData: [
              FloatButtonData(
                  buttonFuction: () {
                    model.addCharToTextField('>');
                  },
                  buttonWidget: Text('>', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
              FloatButtonData(
                  buttonFuction: () {
                    model.addCharToTextField('<');
                  },
                  buttonWidget: Text('<', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
              FloatButtonData(
                  buttonFuction: () {
                    model.addCharToTextField('≥');
                  },
                  buttonWidget: Text('≥', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
              FloatButtonData(
                  buttonFuction: () {
                    model.addCharToTextField('≤');
                  },  
                  buttonWidget: Text('≤', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle)
            ]);
          },
          onLongPress: () {
            FloatButtonOverlay().createOverlay(context, buttonsData: [
              FloatButtonData(
                  buttonFuction: () {
                    model.addCharToTextField('>');
                  },
                  buttonWidget: Text('>', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
              FloatButtonData(
                  buttonFuction: () {
                    model.addCharToTextField('<');
                  },
                  buttonWidget: Text('<', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
              FloatButtonData(
                  buttonFuction: () {
                    model.addCharToTextField('≥');
                  },
                  buttonWidget: Text('≥', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle),
              FloatButtonData(
                  buttonFuction: () {
                    model.addCharToTextField('≤');
                  },
                  buttonWidget: Text('≤', style: textStyle),
                  buttonStyle: overlayButtonStyle ?? defalultOverlayButtonStyle)
            ]);
          },
          style: buttonWithOverlayStyle ?? defalutButtonWithOverlayStyle,
          child: Text('>,<', style: textStyle),
        ),
        _buildCharButton('7', model),
        _buildCharButton('8', model),
        _buildCharButton('9', model),
        _createFunctionButtonWithText(() => model.createCharWidgets('÷'), '÷'),
      ],
      [
        _createFunctionButtonWithIcon(model.onFracButtonTap, CustomMathIcons.frac),
        _createFunctionButtonWithIcon(model.sqrtButtonTap, CustomMathIcons.sqrt),
        _buildCharButton('4', model),
        _buildCharButton('5', model),
        _buildCharButton('6', model),
        _createFunctionButtonWithText(() => model.createCharWidgets('×'), '×'),
      ],
      [
        _createFunctionButtonWithIcon(model.onExpButtonTap, CustomMathIcons.exp),
        _buildCharButton('x', model),
        _buildCharButton('1', model),
        _buildCharButton('2', model),
        _buildCharButton('3', model),
        _createFunctionButtonWithText(() => model.createCharWidgets('-'), '-'),
      ],
      [
        _buildCharButton('π', model),
        _buildCharButton('%', model),
        _buildCharButton('0', model),
        _buildCharButton(',', model),
        Builder(builder: (context) {
          return TextButton(
              onLongPress: () {
                FloatButtonOverlay().createOverlay(context, buttonsData: [
                  FloatButtonData(
                      buttonFuction: () {
                        model.createCharWidgets('≠');
                      },
                      buttonWidget: Text('≠', style: textStyle))
                ]);
              },
              onPressed: () {
                model.createCharWidgets('=');
              },
              style: buttonWithOverlayStyle ?? defalutButtonWithOverlayStyle,
              child: Text('=', style: textStyle));
        }),
        Builder(builder: (context) {
          return TextButton(
              onLongPress: () {
                FloatButtonOverlay().createOverlay(context, buttonsData: [
                  FloatButtonData(
                      buttonFuction: () {
                        model.createCharWidgets('±');
                      },
                      buttonWidget: Text('±', style: textStyle))
                ]);
              },
              onPressed: () {
                model.createCharWidgets('+');
              },
              style: buttonWithOverlayStyle ?? defalutButtonWithOverlayStyle,
              child: Text('+', style: textStyle));
        }),
      ],
    ]; 
    
    return KeyboardPageWidget(pageRows: rows, keyboardPaddings: keyboardPaddings, keyboardSpacing: keyboardSpacing);
  }

  TextButton _buildCharButton(String char, MathKeyboardModel model){
    return TextButton(
      onPressed: () => model.addCharToTextField(char),
      style: buttonStyle ?? defaultButtonStyle,
      child: Text(char, style: textStyle)
    );
  }

  TextButton _createFunctionButtonWithIcon(Function function, IconData icon ){
    return TextButton(
      onPressed: () => function(),
      style: buttonStyle ?? defaultButtonStyle,
      child: Icon(icon, color: textStyle?.color, size: iconSize)
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

class FloatButtonOverlay{
  OverlayEntry? _overlayEntry;
  
  void createOverlay(BuildContext context, {required List<FloatButtonData> buttonsData}){
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox; 
    final offset = renderBox.localToGlobal(Offset.zero);
    final List<Widget >buttonsWidgets = [];
    for(int index= 0; index < buttonsData.length; index++){
      buttonsWidgets.add(SizedBox(
        height: 50,
        child: TextButton(
            style: defalultOverlayButtonStyle,
            onPressed: () {
              buttonsData[index].buttonFuction();
              _deleteOverlay(); 
            },
            child: buttonsData[index].buttonWidget),
      ),);
      buttonsWidgets.add(const SizedBox(width: 5,));
    } 
    late final double offestDx;
    if(offset.dx - (buttonsData.length-1)*25 > 0){
      offestDx = offset.dx - (buttonsData.length-1)*25;
    } 
    else{ 
      offestDx = 0;
    }

    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            left: offestDx,
            top: offset.dy - 55,
            child: Row(
              children: buttonsWidgets
            )));
    overlay.insert(_overlayEntry!); 
    Future.delayed(const Duration(seconds: 2)).then((_)=> _deleteOverlay()); 
  }

  void _deleteOverlay(){
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class FloatButtonData{ 
  final Function buttonFuction; 
  final Widget buttonWidget;
  final ButtonStyle? buttonStyle;

  FloatButtonData({required this.buttonFuction, required this.buttonWidget, this.buttonStyle}); 
}