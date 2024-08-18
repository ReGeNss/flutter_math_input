import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
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
                    model.NamedFunctionButtonTap('cos',ElementsType.cosElement);
                  },
                  style: _buttonStyle,
                  child: const Text('cos')),
            ),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    model.NamedFunctionButtonTap('arccos',ElementsType.arccosElement);
                  },
                  style: _buttonStyle,
                  child: const Text('arccos'),
                )),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.NamedFunctionButtonTap('lg',ElementsType.decimalLogElement);},
                    style: _buttonStyle,
                    child: const Text('lg'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.absButtonTap();},
                    style: _buttonStyle,
                    child: const Text('abs'))),
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
                      model.NamedFunctionButtonTap('sin',ElementsType.sinElement);
                    },
                    style: _buttonStyle,
                    child: const Text('sin'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // sqrtButtonTap(context);
                      model.NamedFunctionButtonTap('arcsin',ElementsType.arcsinElement);
                    },
                    style: _buttonStyle,
                    child: const Text('arcsin'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.NamedFunctionButtonTap('log₂',ElementsType.logBaseTwoElement);},
                    style: _buttonStyle,
                    child: const Text('log₂'))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {model.limButtonTap(); },
                    style: _buttonStyle,
                    icon: const Icon(CustomMathIcons.lim))),
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
                      model.textFieldService.addCharToTextField('∞'); 
                    },
                    style: _buttonStyle,
                    child: const Text('∞'))),
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
                      model.NamedFunctionButtonTap('tan',ElementsType.tanElement);
                    },
                    style: _buttonStyle,
                    child: const Text('tan'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.NamedFunctionButtonTap('arctan',ElementsType.arctanElement);},
                    style: _buttonStyle,
                    child: const Text('arctan'))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {model.logButtonTap() ;},
                    style: _buttonStyle,
                    icon: const Icon(CustomMathIcons.log))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    icon: const Icon(CustomMathIcons.integral))),
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
                    onPressed: () {model.NamedFunctionButtonTap('cot',ElementsType.cotElement);},
                    style: _buttonStyle,
                    child: const Text('cot'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.NamedFunctionButtonTap('arccot',ElementsType.arccotElement);
                    },
                    style: _buttonStyle,
                    child: const Text('arccot'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.NamedFunctionButtonTap('ln',ElementsType.naturalLogElement);},
                    style: _buttonStyle,
                    child: const Text('ln'))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {
                      // formulaParseToString(context);
                    },
                    style: _buttonStyle,
                    icon: const Icon(CustomMathIcons.indefinite_integral))),
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