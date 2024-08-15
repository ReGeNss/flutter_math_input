import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:provider/provider.dart';

final _buttonStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));

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
              // model.createCharWidgets('α');
              model.texParsingService.start(model.formulaGroopWidgets);
            },
            style: _buttonStyle,
            child: const Text('α'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('β');
            },
            style: _buttonStyle,
            child: const Text('β'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('γ');
            },
            style: _buttonStyle,
            child: const Text('γ'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('Δ');
            },
            style: _buttonStyle,
            child: const Text('Δ'),
          ),          
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('ε');
            },
            style: _buttonStyle,
            child: const Text('ε'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('η');
            },
            style: _buttonStyle,
            child: const Text('η'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('θ');
            },
            style: _buttonStyle,
            child: const Text('θ'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('σ');
            },
            style: _buttonStyle,
            child: const Text('σ'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('𝜏');
            },
            style: _buttonStyle,
            child: const Text('𝜏'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('φ');
            },
            style: _buttonStyle,
            child: const Text('φ'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('	ψ');
            },
            style: _buttonStyle,
            child: const Text('	ψ'),
          ),
        ),
        const SizedBox(width: spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.createCharWidgets('ω');
            },
            style: _buttonStyle,
            child: const Text('ω'),
          ),
        ),
      ]),
    ));
  }
}