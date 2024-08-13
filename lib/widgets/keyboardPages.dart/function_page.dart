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
                    model.NamedFunctionButtonTap('cos');
                  },
                  style: _buttonStyle,
                  child: const Text('cos')),
            ),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    model.NamedFunctionButtonTap('arccos');
                  },
                  style: _buttonStyle,
                  child: const Text('arccos'),
                )),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.NamedFunctionButtonTap('lg');},
                    style: _buttonStyle,
                    child: const Text('lg'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('module'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('!');},
                    style: _buttonStyle,
                    child: const Text('!'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('e'); 
                    },
                    style: _buttonStyle,
                    child: const Text('e'))),
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
                      model.NamedFunctionButtonTap('sin');
                    },
                    style: _buttonStyle,
                    child: const Text('sin'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // sqrtButtonTap(context);
                      model.NamedFunctionButtonTap('arcsin');
                    },
                    style: _buttonStyle,
                    child: const Text('arcsin'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.NamedFunctionButtonTap('log₂');},
                    style: _buttonStyle,
                    child: const Text('log₂'))),
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
                    onPressed: () {},
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
                      model.NamedFunctionButtonTap('tan');
                    },
                    style: _buttonStyle,
                    child: const Text('tan'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.NamedFunctionButtonTap('arctan');},
                    style: _buttonStyle,
                    child: const Text('arctan'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.logButtonTap() ;},
                    style: _buttonStyle,
                    child: const Text('log'))),
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
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text(''))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
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
                    onPressed: () {model.NamedFunctionButtonTap('cot');},
                    style: _buttonStyle,
                    child: const Text('cot'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.NamedFunctionButtonTap('arccot');
                    },
                    style: _buttonStyle,
                    child: const Text('arccot'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.NamedFunctionButtonTap('ln');},
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
                      
                    },
                    style: _buttonStyle,
                    child: const Text(''))),
          ],
        ),
      ],
    );
  }
}