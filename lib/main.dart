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
    var  a= context.read<KeyboardModel>().formulaGroopWidgets;
    final model = context.read<KeyboardModel>();  
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50,),
          const Divider(color: Colors.black,),
          Container(
            color: Colors.grey,
            height: 300,
            width: double.infinity,
            child: SingleChildScrollView(
              
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: model.update==true ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: context.watch<KeyboardModel>().formulaGroopWidgets,
                ) : const Center(child: Text('LOAD')),
              ),
            ),
          ),
          const Divider(color: Colors.black),
          const SizedBox(height: 10,),
          FilledButton(onPressed: (){KeyboardBottomSheet().keyboardBottomSheetWidget(context);}, child: const Text('Show keyboard'))

        ],

      )
    );
  }
}

