import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:provider/provider.dart';


class NumbersPageWidget extends StatelessWidget {
  const NumbersPageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<KeyboardModel>();
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
                      model.textFieldService.addCharToTextField('(');
                    },
                    buttonWidget: const Text('(')),
                FloatButtonData(
                    buttonFuction: () {
                      model.textFieldService.addCharToTextField(')');
                    },
                    buttonWidget: const Text(')'))
              ]);
            },
            style: buttonWithOverlayStyle,
            child: const Text('( )')),
        TextButton(
          onPressed: () {
            FloatButtonOverlay().createOverlay(context, buttonsData: [
              FloatButtonData(
                  buttonFuction: () {
                    model.textFieldService.addCharToTextField('>');
                  },
                  buttonWidget: const Text('>')),
              FloatButtonData(
                  buttonFuction: () {
                    model.textFieldService.addCharToTextField('<');
                  },
                  buttonWidget: const Text('<')),
              FloatButtonData(
                  buttonFuction: () {
                    model.textFieldService.addCharToTextField('≥');
                  },
                  buttonWidget: const Text('≥')),
              FloatButtonData(
                  buttonFuction: () {
                    model.textFieldService.addCharToTextField('≤');
                  },
                  buttonWidget: const Text('≤'))
            ]);
          },
          onLongPress: () {
            FloatButtonOverlay().createOverlay(context, buttonsData: [
              FloatButtonData(
                  buttonFuction: () {
                    model.textFieldService.addCharToTextField('>');
                  },
                  buttonWidget: const Text('>')),
              FloatButtonData(
                  buttonFuction: () {
                    model.textFieldService.addCharToTextField('<');
                  },
                  buttonWidget: const Text('<')),
              FloatButtonData(
                  buttonFuction: () {
                    model.textFieldService.addCharToTextField('≥');
                  },
                  buttonWidget: const Text('≥')),
              FloatButtonData(
                  buttonFuction: () {
                    model.textFieldService.addCharToTextField('≤');
                  },
                  buttonWidget: const Text('≤'))
            ]);
          },
          style: buttonWithOverlayStyle,
          child: const Text('>,<'),
        ),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('7');
            },
            style: buttonStyle,
            child: const Text('7')),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('8');
            },
            style: buttonStyle,
            child: const Text('8')),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('9');
            },
            style: buttonStyle,
            child: const Text('9')),
        TextButton(
            onPressed: () {
              model.createCharWidgets('÷');
            },
            style: buttonStyle,
            child: const Text('÷')),
      ],
      [
        TextButton(
            onPressed: () {
              model.onFracButtonTap();
            },
            style: buttonStyle,
            child: const Icon(CustomMathIcons.frac, color: Colors.black, size: iconSize)),
        Builder(builder: (context) {
          return TextButton(
              onPressed: () {
                model.sqrtButtonTap();
              },
              style: buttonStyle,
              child: const Icon(CustomMathIcons.sqrt, color: Colors.black,size: iconSize));
        }),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('4');
            },
            style: buttonStyle,
            child: const Text('4')),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('5');
            },
            style: buttonStyle,
            child: const Text('5')),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('6');
            },
            style: buttonStyle,
            child: const Text('6')),
        TextButton(
            onPressed: () {
              model.createCharWidgets('×');
            },
            style: buttonStyle,
            child: const Text('×')),
      ],
      [
        TextButton(
            onPressed: () {
              // toSquareTap(context);
              model.onExpButtonTap();
            },
            style: buttonStyle,
            child: const Icon(CustomMathIcons.exp, color: Colors.black, size: iconSize)),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('x');
            },
            style: buttonStyle,
            child: const Text('x')),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('1');
            },
            style: buttonStyle,
            child: const Text('1')),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('2');
            },
            style: buttonStyle,
            child: const Text('2')),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('3');
            },
            style: buttonStyle,
            child: const Text('3')),
        TextButton(
            onPressed: () {
              model.createCharWidgets('-');
            },
            style: buttonStyle,
            child: const Text('-')),
      ],
      [
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('π');
            },
            style: buttonStyle,
            child: const Text('π')),
        TextButton(
            onPressed: () {
              model.createCharWidgets('%');
            },
            style: buttonStyle,
            child: const Text('%')),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('0');
            },
            style: buttonStyle,
            child: const Text('0')),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField(',');
            },
            style: buttonStyle,
            child: const Text(',')),
        Builder(builder: (context) {
          return TextButton(
              onLongPress: () {
                FloatButtonOverlay().createOverlay(context, buttonsData: [
                  FloatButtonData(
                      buttonFuction: () {
                        model.createCharWidgets('≠');
                      },
                      buttonWidget: const Text('≠'))
                ]);
              },
              onPressed: () {
                model.createCharWidgets('=');
              },
              style: buttonWithOverlayStyle,
              child: const Text('='));
        }),
        Builder(builder: (context) {
          return TextButton(
              onLongPress: () {
                FloatButtonOverlay().createOverlay(context, buttonsData: [
                  FloatButtonData(
                      buttonFuction: () {
                        model.createCharWidgets('±');
                      },
                      buttonWidget: const Text('±'))
                ]);
              },
              onPressed: () {
                model.createCharWidgets('+');
              },
              style: buttonWithOverlayStyle,
              child: const Text('+'));
        }),
      ],
    ]; 
    
    return KeyboardPage(pageRows: rows);
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
            style: overlayButtonStyle,
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

  FloatButtonData({required this.buttonFuction, required this.buttonWidget}); 
}