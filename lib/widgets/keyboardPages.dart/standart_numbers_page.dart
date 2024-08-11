import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:provider/provider.dart';

final _buttonStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
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
                child: TextButton(
                    onPressed: () {
                      // fracButtonTap(context);
                      model.onFracButtonTap(); 
                    },
                    style: _buttonStyle,
                    child: const Text('frac'))),
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
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('X'))),
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
                    onPressed: () {model.textFieldService.addCharToTextField('4');},
                    style: _buttonStyle,
                    child: const Text('4'))),
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
                    style: _buttonStyle,
                    child: const Text('+'))),
          ],
        ),
      ],
    );
  }
}