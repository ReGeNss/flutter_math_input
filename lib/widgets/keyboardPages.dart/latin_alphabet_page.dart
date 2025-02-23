import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:provider/provider.dart';


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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<KeyboardModel>();
    late final List<List<Widget>> pageRows; 
    if(!isCapsActive) {
      pageRows = [
        [
          TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('q');
                  },
                  style: buttonStyle,
                  child: const Text('q')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('w');
                  },
                  style: buttonStyle,
                  child: const Text('w')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('e');},
                  style: buttonStyle,
                  child: const Text('e')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('r');},
                  style: buttonStyle,
                  child: const Text('r')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('t');},
                  style: buttonStyle,
                  child: const Text('t')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('y');
                  },
                  style: buttonStyle,
                  child: const Text('y')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('u');
                  },
                  style: buttonStyle,
                  child: const Text('u')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('i');
                  },
                  style: buttonStyle,
                  child: const Text('i')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('o');
                  },
                  style: buttonStyle,
                  child: const Text('o')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('p');
                  },
                  style: buttonStyle,
                  child: const Text('p')),
        ],
        [
          TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('a');},
                  style: buttonStyle,
                  child: const Text('a')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('s');},
                  style: buttonStyle,
                  child: const Text('s')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('d');},
                  style: buttonStyle,
                  child: const Text('d')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('f');
                  },
                  style: buttonStyle,
                  child: const Text('f')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('g');},
                  style: buttonStyle,
                  child: const Text('g')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('h');},
                  style: buttonStyle,
                  child: const Text('h')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('j');},
                  style: buttonStyle,
                  child: const Text('j')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('k');},
                  style: buttonStyle,
                  child: const Text('k')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('l');},
                  style: buttonStyle,
                  child: const Text('l')),
        ],
        [
              TextButton(
                  onPressed: capsButtonTap,
                  style: buttonStyle,
                  child: const Icon(CustomMathIcons.shift, size: 20, color: Colors.black,)),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('z');},
                  style: buttonStyle,
                  child: const Text('z')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('x');},
                  style: buttonStyle,
                  child: const Text('x')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('c');
                  },
                  style: buttonStyle,
                  child: const Text('c')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('v');},
                  style: buttonStyle,
                  child: const Text('v')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('b');
                  },
                  style: buttonStyle,
                  child: const Text('b')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('n');
                  },
                  style: buttonStyle,
                  child: const Text('n')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('m');
                  },
                  style: buttonStyle,
                  child: const Text('m')),
        ]
      ];
    }else{
      pageRows = [
        [
          TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('Q');
                  },
                  style: buttonStyle,
                  child: const Text('Q')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('W');
                  },
                  style: buttonStyle,
                  child: const Text('W')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('E');},
                  style: buttonStyle,
                  child: const Text('E')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('R');},
                  style: buttonStyle,
                  child: const Text('R')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('T');},
                  style: buttonStyle,
                  child: const Text('T')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('Y');
                  },
                  style: buttonStyle,
                  child: const Text('Y')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('U');
                  },
                  style: buttonStyle,
                  child: const Text('U')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('I');
                  },
                  style: buttonStyle,
                  child: const Text('I')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('O');
                  },
                  style: buttonStyle,
                  child: const Text('O')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('P');
                  },
                  style: buttonStyle,
                  child: const Text('P')),
        ],
        [
          TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('A');},
                  style: buttonStyle,
                  child: const Text('A')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('S');},
                  style: buttonStyle,
                  child: const Text('S')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('D');},
                  style: buttonStyle,
                  child: const Text('D')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('F');
                  },
                  style: buttonStyle,
                  child: const Text('F')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('G');},
                  style: buttonStyle,
                  child: const Text('G')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('H');},
                  style: buttonStyle,
                  child: const Text('H')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('J');},
                  style: buttonStyle,
                  child: const Text('J')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('K');},
                  style: buttonStyle,
                  child: const Text('K')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('L');},
                  style: buttonStyle,
                  child: const Text('L')),
        ],
        [
          IconButton(
                  onPressed: () {capsButtonTap();},
                  style: buttonStyle,
                  icon: const Icon(CustomMathIcons.shift_lock,size: 20)),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('Z');},
                  style: buttonStyle,
                  child: const Text('Z')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('X');},
                  style: buttonStyle,
                  child: const Text('X')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('C');
                  },
                  style: buttonStyle,
                  child: const Text('C')),
              TextButton(
                  onPressed: () {model.textFieldService.addCharToTextField('V');},
                  style: buttonStyle,
                  child: const Text('V')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('B');
                  },
                  style: buttonStyle,
                  child: const Text('B')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('N');
                  },
                  style: buttonStyle,
                  child: const Text('N')),
              TextButton(
                  onPressed: () {
                    model.textFieldService.addCharToTextField('M');
                  },
                  style: buttonStyle,
                  child: const Text('M')),
        ]
      ];
    }
    return KeyboardPage(pageRows: pageRows); 
  }
}