import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:provider/provider.dart';

final _buttonStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));


class FunctionPageWidget extends StatelessWidget {
  const FunctionPageWidget({
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
                  },
                  style: _buttonStyle,
                  child: const Text('cos')),
            ),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () {
                  },
                  style: _buttonStyle,
                  child: const Text('f(x)'),
                )),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('7');},
                    style: _buttonStyle,
                    child: const Text('lg'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('8');},
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('9');},
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
    
                    },
                    style: _buttonStyle,
                    child: const Text(''))),
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
                    child: const Text('sin'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // sqrtButtonTap(context);
                      model.sqrtButtonTap(); 
                    },
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('4');},
                    style: _buttonStyle,
                    child: const Text('log2'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('5');},
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('6');},
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                    },
                    style: _buttonStyle,
                    child: const Text(''))),
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
                    child: const Text('tan'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('1');},
                    style: _buttonStyle,
                    child: const Text('log'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('2');},
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('3');},
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('4');},
                    style: _buttonStyle,
                    child: const Text(''))),
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
                    child: const Text('cot'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {

                    },
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('0');},
                    style: _buttonStyle,
                    child: const Text('ln'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // formulaParseToString(context);
                    },
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      
                    },
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('+', context);
                      
                      // model.selectNextNewFocus(context);
                    },
                    style: _buttonStyle,
                    child: const Text(''))),
          ],
        ),
      ],
    );
  }
}