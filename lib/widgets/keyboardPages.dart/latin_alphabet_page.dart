import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:provider/provider.dart';

final _buttonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(const Color.fromRGBO(211,211,211,0.3),),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));

const double buttonWidth = 35; 
const double buttonHeight = 60;
class LatinAlphabetPageWidget extends StatefulWidget {
  const LatinAlphabetPageWidget({Key? key}) : super(key: key);

  @override
  State<LatinAlphabetPageWidget> createState() => _LatinAlphabetPageWidgetState();
}

class _LatinAlphabetPageWidgetState extends State<LatinAlphabetPageWidget> {
  bool isCapsActive = false; 
  void capsButtonTap(){
    if(isCapsActive){
      isCapsActive = false; 
    }else{
      isCapsActive = true; 
    }
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    final model = context.read<KeyboardModel>();
    late final Widget keyboard; 
     if(!isCapsActive) {
       keyboard= Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('a');
                  },
                  style: _buttonStyle,
                  child: const Text('a')),
            ),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('b');
                  },
                  style: _buttonStyle,
                  child: const Text('b'),
                )),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('c');},
                    style: _buttonStyle,
                    child: const Text('c'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('d');},
                    style: _buttonStyle,
                    child: const Text('d'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('e');},
                    style: _buttonStyle,
                    child: const Text('e'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('f');
                    },
                    style: _buttonStyle,
                    child: const Text('f'))),
                                SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // fracButtonTap(context);
                      model.textFieldService.addCharToTextField('g');
                    },
                    style: _buttonStyle,
                    child: const Text('g'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // sqrtButtonTap(context);
                      model.textFieldService.addCharToTextField('h');
                    },
                    style: _buttonStyle,
                    child: const Text('h'))),
            
            
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('i');},
                    style: _buttonStyle,
                    child: const Text('i'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('j');},
                    style: _buttonStyle,
                    child: const Text('j'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('k');},
                    style: _buttonStyle,
                    child: const Text('k'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('×', context);
                      model.textFieldService.addCharToTextField('l');
                    },
                    style: _buttonStyle,
                    child: const Text('l'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // toSquareTap(context);
                      model.textFieldService.addCharToTextField('m');
                    },
                    style: _buttonStyle,
                    child: const Text('m'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('n');},
                    style: _buttonStyle,
                    child: const Text('n'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('o');},
                    style: _buttonStyle,
                    child: const Text('o'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('p');},
                    style: _buttonStyle,
                    child: const Text('p'))),
                    SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('q');},
                    style: _buttonStyle,
                    child: const Text('q'))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: IconButton(
                    onPressed: () {capsButtonTap();},
                    style: _buttonStyle,
                    icon: const Icon(CustomMathIcons.shift,size: 20,))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('r');},
                    style: _buttonStyle,
                    child: const Text('r'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('s');},
                    style: _buttonStyle,
                    child: const Text('s'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('u');
                    },
                    style: _buttonStyle,
                    child: const Text('u'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('v');},
                    style: _buttonStyle,
                    child: const Text('v'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('w');
                    },
                    style: _buttonStyle,
                    child: const Text('w'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('x');
                    },
                    style: _buttonStyle,
                    child: const Text('x'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('+', context);
                      model.textFieldService.addCharToTextField('y');
                      // model.selectNextNewFocus(context);
                    },
                    style: _buttonStyle,
                    child: const Text('y'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('z');
                    },
                    style: _buttonStyle,
                    child: const Text('z'))),

          ],
        ),
      ],
    );
     }else{
      keyboard= Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('A');
                  },
                  style: _buttonStyle,
                  child: const Text('A')),
            ),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('B');
                  },
                  style: _buttonStyle,
                  child: const Text('B'),
                )),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('C');},
                    style: _buttonStyle,
                    child: const Text('C'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('D');},
                    style: _buttonStyle,
                    child: const Text('D'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('E');},
                    style: _buttonStyle,
                    child: const Text('E'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('F');
                    },
                    style: _buttonStyle,
                    child: const Text('F'))),
                                SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // fracButtonTap(context);
                      model.textFieldService.addCharToTextField('G');
                    },
                    style: _buttonStyle,
                    child: const Text('G'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // sqrtButtonTap(context);
                      model.textFieldService.addCharToTextField('H');
                    },
                    style: _buttonStyle,
                    child: const Text('H'))),
            
            
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('I');},
                    style: _buttonStyle,
                    child: const Text('I'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('J');},
                    style: _buttonStyle,
                    child: const Text('J'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('K');},
                    style: _buttonStyle,
                    child: const Text('K'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('×', context);
                      model.textFieldService.addCharToTextField('L');
                    },
                    style: _buttonStyle,
                    child: const Text('L'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // toSquareTap(context);
                      model.textFieldService.addCharToTextField('M');
                    },
                    style: _buttonStyle,
                    child: const Text('M'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('N');},
                    style: _buttonStyle,
                    child: const Text('N'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('O');},
                    style: _buttonStyle,
                    child: const Text('O'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('P');},
                    style: _buttonStyle,
                    child: const Text('P'))),
                    SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('Q');},
                    style: _buttonStyle,
                    child: const Text('Q'))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: IconButton(
                    onPressed: () {capsButtonTap();},
                    style: _buttonStyle,
                    icon:  const Icon(CustomMathIcons.shift_lock,size: 20))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('R');},
                    style: _buttonStyle,
                    child: const Text('R'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('S');},
                    style: _buttonStyle,
                    child: const Text('S'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('U');
                    },
                    style: _buttonStyle,
                    child: const Text('U'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {model.textFieldService.addCharToTextField('V');},
                    style: _buttonStyle,
                    child: const Text('V'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('W');
                    },
                    style: _buttonStyle,
                    child: const Text('W'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('X');
                    },
                    style: _buttonStyle,
                    child: const Text('X'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      // model.charButtonTap('+', context);
                      model.textFieldService.addCharToTextField('Y');
                      // model.selectNextNewFocus(context);
                    },
                    style: _buttonStyle,
                    child: const Text('Y'))),
            SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: TextButton(
                    onPressed: () {
                      model.textFieldService.addCharToTextField('Z');
                    },
                    style: _buttonStyle,
                    child: const Text('Z'))),

          ],
        ),
      ],
    );
     }
     return keyboard; 
  }
  
} 
