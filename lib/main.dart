import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:math_keyboard/widgets/math_input.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (_) => MathKeyboardModel(),
      child: const MaterialApp(
        home: MainScreenWidget(),
      ),
    );
  }
}

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainScreenColumnWidget()
    );
  }
}

class MainScreenColumnWidget extends StatelessWidget {
  const MainScreenColumnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) { 
  final model = context.watch<MathKeyboardModel>();  
    return Column(
      children: [
        const SizedBox(height: 50,),
        Math.tex(model.formulaInTeX ?? ''),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MathInputWidget(),
        ),  
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                  onPressed: () {
                    BasicMathKeyboard(context: context).showKeyboard();
                  },
                  child: const Text('Show keyboard')),
              const SizedBox(width: 10,),
              Expanded(
                child: FilledButton(
                    onPressed: () {
                      model.formulaInTeX = model.getFormulaKaTeX();
                      model.rebuildSreenState();
                    },
                    child: const Text("Translate formula to KaTeX", textAlign: TextAlign.center,)),
              )
            ],
          ),
        )
    
      ],
    
    );
  }
}

