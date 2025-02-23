import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:provider/provider.dart';



class FunctionPageWidget extends StatelessWidget {
  const FunctionPageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<KeyboardModel>();
    final List<List<Widget>> rows = [
      [
        TextButton(
            onPressed: () {
              model.namedFunctionButtonTap('cos', ElementsType.cosElement);
            },
            style: buttonStyle,
            child: const Text('cos')),
        TextButton(
          onPressed: () {
            model.namedFunctionButtonTap('arccos', ElementsType.arccosElement);
          },
          style: buttonStyle,
          child: const Text('arccos'),
        ),
        TextButton(
            onPressed: () {
              model.namedFunctionButtonTap(
                  'lg', ElementsType.decimalLogElement);
            },
            style: buttonStyle,
            child: const Text('lg')),
        TextButton(
            onPressed: () {
              model.absButtonTap();
            },
            style: buttonStyle,
            child: const Icon(CustomMathIcons.abs, color: Colors.black, size: iconSize)),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('!');
            },
            style: buttonStyle,
            child: const Text('!')),
        TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('e');
            },
            style: buttonStyle,
            child: const Text('e')),
      ],
      [
        TextButton(
              onPressed: () {
                // fracButtonTap(context);
                model.namedFunctionButtonTap('sin',ElementsType.sinElement);
              },
              style: buttonStyle,
              child: const Text('sin')),
            TextButton(
              onPressed: () {
                // sqrtButtonTap(context);
                model.namedFunctionButtonTap('arcsin',ElementsType.arcsinElement);
              },
              style: buttonStyle,
              child: const Text('arcsin')),
            TextButton(
              onPressed: () {model.namedFunctionButtonTap('log₂',ElementsType.logBaseTwoElement);},
              style: buttonStyle,
              child: const Text('log₂')),
            TextButton(
              onPressed: model.limButtonTap,
              style: buttonStyle,
              child: const Icon(CustomMathIcons.lim, color: Colors.black, size: iconSize)),
            TextButton(
              onPressed: () {model.textFieldService.addCharToTextField('f(x)');},
              style: buttonStyle,
              child: const Text('f(x)')),
            TextButton(
              onPressed: () {
                model.textFieldService.addCharToTextField('∞'); 
              },
              style: buttonStyle,
              child: const Text('∞')),
      ],
      [
        TextButton(
              onPressed: () {
                // toSquareTap(context);
                model.namedFunctionButtonTap('tan',ElementsType.tanElement);
              },
              style: buttonStyle,
              child: const Text('tan')),
            TextButton(
              onPressed: () {model.namedFunctionButtonTap('arctan',ElementsType.arctanElement);},
              style: buttonStyle,
              child: const Text('arctan')),
            TextButton(
              onPressed: () {model.logButtonTap() ;},
              style: buttonStyle,
              child: const Icon(CustomMathIcons.log, color: Colors.black, size: iconSize)),
            TextButton(
              onPressed: () {model.integralButtonTap();},
              style: buttonStyle,
              child: const Icon(CustomMathIcons.integral, color: Colors.black ,size: iconSize)),
            TextButton(
              onPressed: () {model.onDerevativeButtonTap(upperField: 'x',downField: 'y');},
              style: buttonStyle,
              child: const Icon(CustomMathIcons.dx_dy, color: Colors.black, size: iconSize,)),
            TextButton(
              onPressed: () {},
              style: buttonStyle,
              child: const Text('')),
      ],
      [
        TextButton(
              onPressed: () {model.namedFunctionButtonTap('cot',ElementsType.cotElement);},
              style: buttonStyle,
              child: const Text('cot')),
            TextButton(
              onPressed: () {
                model.namedFunctionButtonTap('arcctg',ElementsType.arccotElement);
              },
              style: buttonStyle,
              child: const Text('arcctg')),
            TextButton(
              onPressed: () {model.namedFunctionButtonTap('ln',ElementsType.naturalLogElement);},
              style: buttonStyle,
              child: const Text('ln')),
            TextButton(
              onPressed: () {
                model.undefinitintegralButtonTap();
              },
              style: buttonStyle,
              child: const Icon(CustomMathIcons.indefinite_integral, color: Colors.black, size: iconSize)),
            TextButton(
              onPressed: () {
                model.onDerevativeButtonTap(); 
              },
              style: buttonStyle,
              child: const Icon(CustomMathIcons.derevative, color: Colors.black, size: iconSize)),
            TextButton(
              onPressed: () {
                
              },
              style: buttonStyle,
              child: const Text('')),
      ]

    ];

    return KeyboardPage(pageRows: rows);
  }
}