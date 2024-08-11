import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/function_page.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/latin_alphabet_page.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/standart_numbers_page.dart';
import 'package:provider/provider.dart';

final _buttonStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));

class KeyboardBottomSheet{
  final List<Widget> keyboardFormat = const [KeyboardNumbersButtomWidget(),FunctionPageWidget(),LatinAlphabetPageWidget()];
  int selectedKeyboardFormat = 0; 

  Future<dynamic> keyboardBottomSheetWidget(BuildContext context) {
    final model = context.read<KeyboardModel>();
    return showModalBottomSheet(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return SizedBox(
          height: 300,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          onPressed: () {
                            context.read<KeyboardModel>().selectBackFocus();
                        
                          },
                          icon: const Icon(Icons.arrow_back),
                          style: _buttonStyle,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          onPressed: () {
                            context.read<KeyboardModel>().selectNextFocus(); 
                          },
                          icon: const Icon(Icons.arrow_forward),
                          style: _buttonStyle,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          onPressed: () {
                            selectedKeyboardFormat = 0; 
                            setState((){}); 
                          },
                          icon: const Icon(Icons.pin_outlined),
                          style: _buttonStyle,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          onPressed: () {
                            selectedKeyboardFormat = 1; 
                            setState((){}); 
                          },
                          icon: const Icon(Icons.functions_outlined),
                          style: _buttonStyle,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          onPressed: () {
                            selectedKeyboardFormat = 2; 
                            setState(() {
                              
                            });
                          },
                          icon: const Icon(Icons.abc_outlined),
                          style: _buttonStyle,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          onPressed: () {
                            final model = context.read<KeyboardModel>();
                            model.deleteAllButtonTap();
                            // model.activeTextFieldController = null;
                            // model.focusNodes = [];
                            // model.listWidgetLustrations = [];
                            // model.textEditingControllers = [];
                            // model.createStartField();
                            // model.notify();
                          },
                          icon: const Icon(Icons.delete_outline),
                          style: _buttonStyle,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 4,
                  child: keyboardFormat[selectedKeyboardFormat],
                ),
              ],
            ),
          ),
        );
          },
        );
         
      },
    );
  }
  
}

