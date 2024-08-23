import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/standart_numbers_page.dart';
import 'package:provider/provider.dart';

// final buttonStyle = ButtonStyle(
//     shape: WidgetStateProperty.all(
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
//     foregroundColor: WidgetStateProperty.all(Colors.black),
//     side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));

const double spaceBetweenWidth = 10; 

class scroolGreekSymbolsWidget extends StatelessWidget {
  const scroolGreekSymbolsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<KeyboardModel>(); 
    return SizedBox(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('α');
              model.formulaInTeX= model.texParsingService.start(model.formulaGroopWidgets);
              model.rebuildSreenState();
            },
            style: buttonStyle,
            child: const Text('α'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('β');
            },
            style: buttonStyle,
            child: const Text('β'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('γ');
            },
            style: buttonStyle,
            child: const Text('γ'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('Δ');
            },
            style: buttonStyle,
            child: const Text('Δ'),
          ),          
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('ε');
            },
            style: buttonStyle,
            child: const Text('ε'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('η');
            },
            style: buttonStyle,
            child: const Text('η'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('θ');
            },
            style: buttonStyle,
            child: const Text('θ'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('σ');
            },
            style: buttonStyle,
            child: const Text('σ'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('𝜏');
            },
            style: buttonStyle,
            child: const Text('𝜏'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('φ');
            },
            style: buttonStyle,
            child: const Text('φ'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('ψ');
            },
            style: buttonStyle,
            child: const Text('	ψ'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.textFieldService.addCharToTextField('ω');
            },
            style: buttonStyle,
            child: const Text('ω'),
          ),
        ),
      ]),
    ));
  }
}