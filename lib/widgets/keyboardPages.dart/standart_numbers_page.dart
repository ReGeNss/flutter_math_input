import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:provider/provider.dart';

final _buttonStyle = ButtonStyle(
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
                    // if (context.read<KeyboardModel>().changeHandler == true) {
                    //   context.read<KeyboardModel>().changeHandler = false;
                    // } else {
                    //   context.read<KeyboardModel>().changeHandler = true;
                    // }
                    // context.read<KeyboardModel>().notify();
                  },
                  style: _buttonStyle,
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
                  style: _buttonStyle,
                  child: const Text('>'),
                )),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('7');},
                    style: _buttonStyle,
                    child: const Text('7'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('8');},
                    style: _buttonStyle,
                    child: const Text('8'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('9');},
                    style: _buttonStyle,
                    child: const Text('9'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.createCharWidgets('÷');
                    },
                    style: _buttonStyle,
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
                    style: _buttonStyle,
                    icon: const Text('frac'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // sqrtButtonTap(context);
                      model.sqrtButtonTap(); 
                    },
                    style: _buttonStyle,
                    child: const Text('sqrt'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('4');},
                    style: _buttonStyle,
                    child: const Text('4'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('5');},
                    style: _buttonStyle,
                    child: const Text('5'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('6');},
                    style: _buttonStyle,
                    child: const Text('6'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('×', context);
                      model.createCharWidgets('×');
                    },
                    style: _buttonStyle,
                    child: const Text('×'))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // toSquareTap(context);
                      model.onExpButtonTap(); 
                    },
                    style: _buttonStyle,
                    child: const Text('^2'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('x');},
                    style: _buttonStyle,
                    child: const Text('x'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('1');},
                    style: _buttonStyle,
                    child: const Text('1'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('2');},
                    style: _buttonStyle,
                    child: const Text('2'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('3');},
                    style: _buttonStyle,
                    child: const Text('3'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.createCharWidgets('-');},
                    style: _buttonStyle,
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
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('π'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.createCharWidgets('%');
                    },
                    style: _buttonStyle,
                    child: const Text('%'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('0');},
                    style: _buttonStyle,
                    child: const Text('0'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // formulaParseToString(context);
                      model.textFieldService.addCharToTextField(',');
                    },
                    style: _buttonStyle,
                    child: const Text(','))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.createCharWidgets('=');
                    },
                    style: _buttonStyle,
                    child: const Text('='))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('+', context);
                      model.createCharWidgets('+');
                      // model.selectNextNewFocus(context);
                    },
                    // onLongPress: () {                   
                    //   final overlay = Overlay.of(context); 
                    //   final overlayEntry = OverlayEntry(builder: (context) {
                    //     return Positioned(
                    //         top: MediaQuery.of(context).size.height-100,
                    //         left: MediaQuery.of(context).size.width-100,
                    //         child: Row(
                    //           children: [
                    //             TextButton(onPressed: (){overlayEntry.remove();},style: _popButtonStyle, child: const Text('±'),),
                    //           ],
                    //         ));
                    //   });
                    //   overlay.insert(overlayEntry);
                    // },
                    style: _buttonStyle,
                    child: const Text('+'))),
          ],
        ),
      ],
    );
  }
}