import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/standart_numbers_page.dart';
import 'package:provider/provider.dart';



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
                    model.namedFunctionButtonTap('cos',ElementsType.cosElement);
                  },
                  style: buttonStyle,
                  child: const Text('cos')),
            ),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    model.namedFunctionButtonTap('arccos',ElementsType.arccosElement);
                  },
                  style: buttonStyle,
                  child: const Text('arccos'),
                )),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.namedFunctionButtonTap('lg',ElementsType.decimalLogElement);},
                    style: buttonStyle,
                    child: const Text('lg'))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {model.absButtonTap();},
                    style: buttonStyle,
                    icon: const Icon(CustomMathIcons.abs,size: iconSize))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('!');},
                    style: buttonStyle,
                    child: const Text('!'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('e'); 
                    },
                    style: buttonStyle,
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
                      model.namedFunctionButtonTap('sin',ElementsType.sinElement);
                    },
                    style: buttonStyle,
                    child: const Text('sin'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // sqrtButtonTap(context);
                      model.namedFunctionButtonTap('arcsin',ElementsType.arcsinElement);
                    },
                    style: buttonStyle,
                    child: const Text('arcsin'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.namedFunctionButtonTap('log₂',ElementsType.logBaseTwoElement);},
                    style: buttonStyle,
                    child: const Text('log₂'))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {model.limButtonTap(); },
                    style: buttonStyle,
                    icon: const Icon(CustomMathIcons.lim,size: iconSize))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('f(x)');},
                    style: buttonStyle,
                    child: const Text('f(x)'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('∞'); 
                    },
                    style: buttonStyle,
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
                      model.namedFunctionButtonTap('tan',ElementsType.tanElement);
                    },
                    style: buttonStyle,
                    child: const Text('tan'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.namedFunctionButtonTap('arctan',ElementsType.arctanElement);},
                    style: buttonStyle,
                    child: const Text('arctan'))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {model.logButtonTap() ;},
                    style: buttonStyle,
                    icon: const Icon(CustomMathIcons.log,size: iconSize))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {model.integralButtonTap();},
                    style: buttonStyle,
                    icon: const Icon(CustomMathIcons.integral,size: iconSize))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {model.onDerevativeButtonTap(upperField: 'x',downField: 'y');},
                    style: buttonStyle,
                    icon: const Icon(CustomMathIcons.dx_dy,size: iconSize,))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: buttonStyle,
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
                    onPressed: () {model.namedFunctionButtonTap('cot',ElementsType.cotElement);},
                    style: buttonStyle,
                    child: const Text('cot'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      model.namedFunctionButtonTap('arcctg',ElementsType.arccotElement);
                    },
                    style: buttonStyle,
                    child: const Text('arcctg'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {model.namedFunctionButtonTap('ln',ElementsType.naturalLogElement);},
                    style: buttonStyle,
                    child: const Text('ln'))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {
                      model.undefinitintegralButtonTap();
                    },
                    style: buttonStyle,
                    icon: const Icon(CustomMathIcons.indefinite_integral,size: iconSize))),
            SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                    onPressed: () {
                      model.onDerevativeButtonTap(); 
                    },
                    style: buttonStyle,
                    icon: const Icon(CustomMathIcons.derevative,size: iconSize))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      
                    },
                    style: buttonStyle,
                    child: const Text(''))),
          ],
        ),
      ],
    );
  }
}