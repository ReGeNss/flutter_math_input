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
      create: (_) => MathController(),
      child: const MaterialApp(
        home: MainScreenWidget(),
      ),
    );
  }
}

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({
    super.key
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const SizedBox(height: 50,),
          MathInput(),  
          const SizedBox(height: 10,),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
                onPressed: () {
                  BasicMathKeyboard(context: context).showKeyboard();
                },
                child: const Text('Show keyboard')),
          ),
          const SizedBox(height: 10,),
          const FormulaByGetDemo(),
          const SizedBox(height: 10,),
          const FormulaByStreamDemo()
        ],
      
      ),
    );
  }
}

class FormulaByGetDemo extends StatefulWidget {
  const FormulaByGetDemo({super.key});

  @override
  State<FormulaByGetDemo> createState() => _FormulaByGetDemoState();
}

class _FormulaByGetDemoState extends State<FormulaByGetDemo> {
  var formula = "";
  
  @override
  Widget build(BuildContext context) {
    final model = context.read<MathController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  spacing: 10,
                  children: [
                    Text("Formula by trigger"),
                    Math.tex(formula, textStyle: TextStyle(fontSize: 20),)
                  ],
                )
              ),
            ),
            const SizedBox(width: 10,),
            FilledButton(
              onPressed: () {
                final formulaResult = model.getFormulaKaTeX();
                if (formulaResult is String) {
                  formula = formulaResult;
                  setState(() {});
                } else {
                  formula = "loading...";
                  formulaResult.then((katexFormula) {
                    formula = katexFormula;
                    setState(() {});
                  });
                }
              },
            child: const Text("trigger",  textAlign: TextAlign.center,)),
          ],
        ),
      ],
    );
  }
}

class FormulaByStreamDemo extends StatefulWidget {
  const FormulaByStreamDemo({super.key});

  @override
  State<FormulaByStreamDemo> createState() => _FormulaByStreamDemoState();
}

class _FormulaByStreamDemoState extends State<FormulaByStreamDemo> {
  var formula = "";
  @override
  void initState() {
    super.initState();
    final model = context.read<MathController>();
    model.katexFormulaStream.listen((event) {
      setState(() {
        formula = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 10,
        children: [
          const Text("Formula by stream"),
          Math.tex(formula, textStyle: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
}