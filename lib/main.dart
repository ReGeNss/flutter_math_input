import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
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
      create: (_) => KeyboardModel(),
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Divider(color: Colors.black,),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: context.select((KeyboardModel model) => model.formulaGroopWidgets),
                // children: context.watch<KeyboardModel>().formulaGroopWidgets
              ),
            ),
          ),
          Divider(color: Colors.black),
          SizedBox(height: 10,),
          FilledButton(onPressed: (){KeyboardBottomSheet().keyboardBottomSheetWidget(context);}, child: Text('Show keyboard'))

        ],

      )
    );
  }
}
