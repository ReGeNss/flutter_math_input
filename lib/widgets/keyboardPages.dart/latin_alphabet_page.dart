import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:provider/provider.dart';

final _buttonStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));

const double buttonWidth = 35; 
const double buttonHeight = 60;
class LatinAlphabetPageWidget extends StatelessWidget {
  const LatinAlphabetPageWidget({Key? key}) : super(key: key);

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
              width: buttonWidth,
              height: buttonHeight,
              child: TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('a');
                  },
                  style: _buttonStyle,
                  child: const Text('a')),
            ),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('b');
                  },
                  style: _buttonStyle,
                  child: const Text('b'),
                )),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('c');},
                    style: _buttonStyle,
                    child: const Text('c'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('d');},
                    style: _buttonStyle,
                    child: const Text('d'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('e');},
                    style: _buttonStyle,
                    child: const Text('e'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('f');
                    },
                    style: _buttonStyle,
                    child: const Text('f'))),
                                SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // fracButtonTap(context);
                      model.textFieldService.addCharToTextField('g');
                    },
                    style: _buttonStyle,
                    child: const Text('g'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // sqrtButtonTap(context);
                      model.textFieldService.addCharToTextField('h');
                    },
                    style: _buttonStyle,
                    child: const Text('h'))),
            
            
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('i');},
                    style: _buttonStyle,
                    child: const Text('i'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('j');},
                    style: _buttonStyle,
                    child: const Text('j'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('k');},
                    style: _buttonStyle,
                    child: const Text('k'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('×', context);
                      model.textFieldService.addCharToTextField('l');
                    },
                    style: _buttonStyle,
                    child: const Text('l'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // toSquareTap(context);
                      model.textFieldService.addCharToTextField('m');
                    },
                    style: _buttonStyle,
                    child: const Text('m'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('n');},
                    style: _buttonStyle,
                    child: const Text('n'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('o');},
                    style: _buttonStyle,
                    child: const Text('o'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('p');},
                    style: _buttonStyle,
                    child: const Text('p'))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('q');},
                    style: _buttonStyle,
                    child: const Text('q'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('r');},
                    style: _buttonStyle,
                    child: const Text('r'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('s');},
                    style: _buttonStyle,
                    child: const Text('s'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('u');
                    },
                    style: _buttonStyle,
                    child: const Text('u'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('v');},
                    style: _buttonStyle,
                    child: const Text('v'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('w');
                    },
                    style: _buttonStyle,
                    child: const Text('w'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('x');
                    },
                    style: _buttonStyle,
                    child: const Text('x'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('+', context);
                      model.textFieldService.addCharToTextField('y');
                      // model.selectNextNewFocus(context);
                    },
                    style: _buttonStyle,
                    child: const Text('y'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('z');
                    },
                    style: _buttonStyle,
                    child: const Text('z'))),

          ],
        ),
      ],
    );
  }
} 
