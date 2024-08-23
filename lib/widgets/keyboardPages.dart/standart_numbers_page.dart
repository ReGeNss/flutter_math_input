import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/latin_alphabet_page.dart';
import 'package:provider/provider.dart';

final buttonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Color.fromRGBO(211,211,211,0.3),),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));
final _overlayButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.grey),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));


final _popButtonStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    backgroundColor: WidgetStateProperty.all(Colors.white70),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));


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
                  style: buttonStyle,
                  child: const Text('( )')),
            ),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    // model.('>', context);
                    model.createCharWidgets('>');
                  },
                  style: buttonStyle,
                  child: const Text('>'),
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
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {
                      // sqrtButtonTap(context);
                      model.sqrtButtonTap(); 
                    },
                    style: buttonStyle,
                    icon: const Icon(CustomMathIcons.sqrt,size: iconSize))),
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
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.createCharWidgets('=');
                    },
                    style: buttonStyle,
                    child: const Text('='))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.createCharWidgets('+');
                    },
                    style: buttonStyle,
                    child: const Text('+'))),
            // SizedBox(
            //     width: 50,
            //     height: 50,
            //     child: addButtonWidget(model: model)),
          ],
        ),
      ],
    );
  }
}

// class addButtonWidget extends StatefulWidget {
//   const addButtonWidget({
//     super.key,
//     required this.model,
//   });

//   final KeyboardModel model;

//   @override
//   State<addButtonWidget> createState() => _addButtonWidgetState();
// }

// class _addButtonWidgetState extends State<addButtonWidget> {
//   OverlayEntry? _overlayEntry;

//   void createOverlay(LongPressStartDetails details){
//     final overlay = Overlay.of(context);
//     final renderBox = context.findRenderObject() as RenderBox; 
//     final offset = renderBox.localToGlobal(Offset.zero);
//     _overlayEntry = OverlayEntry(
//         builder: (context) => Positioned(
//             left: offset.dx,
//             top: offset.dy - buttonHeight,
//             child: Row(
//               children: [
//                 GestureDetector(
//                   onPanStart: (_) => print('some'),
//                   child: Container(
//                       height: 50,
//                       width: 50,
//                       child: TextButton(
//                           style: _overlayButtonStyle,
//                           onPressed: () {
//                             print('TAP');
//                           },
//                           child: Text('+-'))),
//                 )
//               ],
//             )));
//     overlay.insert(_overlayEntry!); 
//   }

//   void deleteOverlay(LongPressEndDetails details){
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPressStart: createOverlay,
//       onLongPressEnd: deleteOverlay,
//       child: TextButton(
//           onPressed: () {
//             widget.model.createCharWidgets('+');
//           },
//           style: _buttonStyle,
//           child: const Text('+')),
//     );
//   }
// }