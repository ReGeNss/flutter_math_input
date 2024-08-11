import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:provider/provider.dart';

final _buttonStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));

class KeyboardBottomSheet{
  final List<Widget> keyboardFormat = [KeyboardNumbersButtomWidget(),Text('data')];
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

class KeyboardNumbersButtomWidget extends StatelessWidget {
  const KeyboardNumbersButtomWidget({
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
                    // if (context.read<KeyboardModel>().changeHandler == true) {
                    //   context.read<KeyboardModel>().changeHandler = false;
                    // } else {
                    //   context.read<KeyboardModel>().changeHandler = true;
                    // }
                    // context.read<KeyboardModel>().notify();
                  },
                  style: _buttonStyle,
                  child: const Text('( )')),
            ),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    // model.('>', context);
                  },
                  style: _buttonStyle,
                  child: const Text('>'),
                )),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('7'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('8'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('9'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('÷', context);
                    },
                    style: _buttonStyle,
                    child: const Text('÷'))),
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
                      model.onFracButtonTap(); 
                    },
                    style: _buttonStyle,
                    child: const Text('frac'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // sqrtButtonTap(context);
                    },
                    style: _buttonStyle,
                    child: const Text('sqrt'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('4'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('5'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('6'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('×', context);
                    },
                    style: _buttonStyle,
                    child: const Text('×'))),
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
                    },
                    style: _buttonStyle,
                    child: const Text('^2'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('X'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('1'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('2'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('3'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('4'))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('π'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('%', context);
                    },
                    style: _buttonStyle,
                    child: const Text('%'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: const Text('0'))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // formulaParseToString(context);
                    },
                    style: _buttonStyle,
                    child: const Text(','))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('=', context);
                    },
                    style: _buttonStyle,
                    child: const Text('='))),
            SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('+', context);
                      model.createCharWidgets('+');
                      // model.selectNextNewFocus(context);
                    },
                    style: _buttonStyle,
                    child: const Text('+'))),
          ],
        ),
      ],
    );
  }
}