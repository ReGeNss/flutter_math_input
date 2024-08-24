import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/latin_alphabet_page.dart';
import 'package:provider/provider.dart';

final buttonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(const Color.fromRGBO(211,211,211,0.3),),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));
final _overlayButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.cyan[100]),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.cyanAccent)));
final _buttonWithOverlayStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(const Color.fromRGBO(211,211,211,0.3),),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.cyanAccent)));


class KeyboardNumbersButtomWidget extends StatelessWidget {
  const KeyboardNumbersButtomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<KeyboardModel>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: TextButton(
                  onPressed: () {
                    model.backetsButtonTap();
                  },
                  onLongPress: (){
                    FloatButtonOverlay().createOverlay(context,buttonsData:[FloatButtonData(buttonFuction: (){model.textFieldService.addCharToTextField('(');}, buttonWidget: const Text('(')),FloatButtonData(buttonFuction: (){model.textFieldService.addCharToTextField(')');}, buttonWidget:const Text(')'))] );
                  }, 
                  style: _buttonWithOverlayStyle,
                  child: const Text('( )')),
            ),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    FloatButtonOverlay().createOverlay(context, buttonsData: [
                      FloatButtonData(
                          buttonFuction: () {
                            model.textFieldService.addCharToTextField('>');
                          },
                          buttonWidget:const Text('>')),
                      FloatButtonData(
                          buttonFuction: () {
                            model.textFieldService.addCharToTextField('<');
                          },
                          buttonWidget:const Text('<')),
                      FloatButtonData(
                          buttonFuction: () {
                            model.textFieldService.addCharToTextField('≥');
                          },
                          buttonWidget:const Text('≥')),
                      FloatButtonData(
                          buttonFuction: () {
                            model.textFieldService.addCharToTextField('≤');
                          },
                          buttonWidget:const Text('≤'))
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
                  style: _buttonWithOverlayStyle,
                  child: const Text('>,<'),
                )),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('7');},
                    style: buttonStyle,
                    child: const Text('7'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('8');},
                    style: buttonStyle,
                    child: const Text('8'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('9');},
                    style: buttonStyle,
                    child: const Text('9'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.createCharWidgets('÷');
                    },
                    style: buttonStyle,
                    child: const Text('÷'))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {
                      model.onFracButtonTap(); 
                    },
                    style: buttonStyle,
                    icon: const Icon(CustomMathIcons.frac,size: iconSize))),
            Builder(
              builder: (context) {
                return SizedBox(
                    width: 50,
                    height: 50,
                    child: TextButton(
                        onLongPress: (){
                          FloatButtonOverlay().createOverlay(context, buttonsData: [FloatButtonData(buttonFuction: (){}, buttonWidget: const Icon(CustomMathIcons.sqrt_extended))]);
                        }, 
                        onPressed: () {
                          model.sqrtButtonTap(); 
                        },
                        style: _buttonWithOverlayStyle,
                        child: const Icon(CustomMathIcons.sqrt,size: iconSize)));
              }
            ),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('4');},
                    style: buttonStyle,
                    child: const Text('4'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('5');},
                    style: buttonStyle,
                    child: const Text('5'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('6');},
                    style: buttonStyle,
                    child: const Text('6'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('×', context);
                      model.createCharWidgets('×');
                    },
                    style: buttonStyle,
                    child: const Text('×'))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {
                      // toSquareTap(context);
                      model.onExpButtonTap(); 
                    },
                    style: buttonStyle,
                    icon: const Icon(CustomMathIcons.exp,size: iconSize))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('x');},
                    style: buttonStyle,
                    child: const Text('x'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('1');},
                    style: buttonStyle,
                    child: const Text('1'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('2');},
                    style: buttonStyle,
                    child: const Text('2'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('3');},
                    style: buttonStyle,
                    child: const Text('3'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.createCharWidgets('-');},
                    style: buttonStyle,
                    child: const Text('-'))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('π');},
                    style: buttonStyle,
                    child: const Text('π'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.createCharWidgets('%');
                    },
                    style: buttonStyle,
                    child: const Text('%'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('0');},
                    style: buttonStyle,
                    child: const Text('0'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // formulaParseToString(context);
                      model.textFieldService.addCharToTextField(',');
                    },
                    style: buttonStyle,
                    child: const Text(','))),
            Builder(
              builder: (context) {
                return SizedBox(
                    width: 50,
                    height: 50,
                    child: TextButton(
                        onPressed: () {
                            FloatButtonOverlay().createOverlay(context, buttonsData: [
                              FloatButtonData(
                                  buttonFuction: () {
                                    model.textFieldService.addCharToTextField('≠');
                                  },
                                  buttonWidget: const Text('≠'))
                            ]);
                          },
                        style: _buttonWithOverlayStyle,
                        child: const Text('=')));
              }
            ),
            Builder(
              builder: (context) {
                return SizedBox(
                    width: 50,
                    height: 50,
                    child: TextButton(
                      onLongPress: () {
                        FloatButtonOverlay().createOverlay(context, buttonsData: [
                          FloatButtonData(
                              buttonFuction: () {
                                model.textFieldService.addCharToTextField('±');
                              },
                              buttonWidget: const Text('±'))
                        ]);
                      },
                        onPressed: () {
                          model.createCharWidgets('+');
                        },
                        style: _buttonWithOverlayStyle,
                        child: const Text('+')));
              }
            ),
            // SizedBox(
            //     width: 50,
            //     height: 50,
            //     child: floatButtonsWidget(model: model)),
          ],
        ),
      ],
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
                    width: 50,
                    child: TextButton(
                        style: _overlayButtonStyle,
                        onPressed: () {
                          buttonsData[index].buttonFuction();
                          _deleteOverlay(); 
                        },
                        child: buttonsData[index].buttonWidget)),);
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