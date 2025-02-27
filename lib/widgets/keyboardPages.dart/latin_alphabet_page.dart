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
                    model.addCharToTextField('q');
                  },
                  style: buttonStyle,
                  child: const Text('q')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('w');
                  },
                  style: buttonStyle,
                  child: const Text('w')),
              TextButton(
                  onPressed: () {model.addCharToTextField('e');},
                  style: buttonStyle,
                  child: const Text('e')),
              TextButton(
                  onPressed: () {model.addCharToTextField('r');},
                  style: buttonStyle,
                  child: const Text('r')),
              TextButton(
                  onPressed: () {model.addCharToTextField('t');},
                  style: buttonStyle,
                  child: const Text('t')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('y');
                  },
                  style: buttonStyle,
                  child: const Text('y')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('u');
                  },
                  style: buttonStyle,
                  child: const Text('u')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('i');
                  },
                  style: buttonStyle,
                  child: const Text('i')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('o');
                  },
                  style: buttonStyle,
                  child: const Text('o')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('p');
                  },
                  style: buttonStyle,
                  child: const Text('p')),
        ],
        [
          TextButton(
                  onPressed: () {model.addCharToTextField('a');},
                  style: buttonStyle,
                  child: const Text('a')),
              TextButton(
                  onPressed: () {model.addCharToTextField('s');},
                  style: buttonStyle,
                  child: const Text('s')),
              TextButton(
                  onPressed: () {model.addCharToTextField('d');},
                  style: buttonStyle,
                  child: const Text('d')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('f');
                  },
                  style: buttonStyle,
                  child: const Text('f')),
              TextButton(
                  onPressed: () {model.addCharToTextField('g');},
                  style: buttonStyle,
                  child: const Text('g')),
              TextButton(
                  onPressed: () {model.addCharToTextField('h');},
                  style: buttonStyle,
                  child: const Text('h')),
              TextButton(
                  onPressed: () {model.addCharToTextField('j');},
                  style: buttonStyle,
                  child: const Text('j')),
              TextButton(
                  onPressed: () {model.addCharToTextField('k');},
                  style: buttonStyle,
                  child: const Text('k')),
              TextButton(
                  onPressed: () {model.addCharToTextField('l');},
                  style: buttonStyle,
                  child: const Text('l')),
        ],
        [
              TextButton(
                  onPressed: capsButtonTap,
                  style: buttonStyle,
                  child: const Icon(CustomMathIcons.shift, size: 20, color: Colors.black,)),
              TextButton(
                  onPressed: () {model.addCharToTextField('z');},
                  style: buttonStyle,
                  child: const Text('z')),
              TextButton(
                  onPressed: () {model.addCharToTextField('x');},
                  style: buttonStyle,
                  child: const Text('x')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('c');
                  },
                  style: buttonStyle,
                  child: const Text('c')),
              TextButton(
                  onPressed: () {model.addCharToTextField('v');},
                  style: buttonStyle,
                  child: const Text('v')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('b');
                  },
                  style: buttonStyle,
                  child: const Text('b')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('n');
                  },
                  style: buttonStyle,
                  child: const Text('n')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('m');
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
                    model.addCharToTextField('Q');
                  },
                  style: buttonStyle,
                  child: const Text('Q')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('W');
                  },
                  style: buttonStyle,
                  child: const Text('W')),
              TextButton(
                  onPressed: () {model.addCharToTextField('E');},
                  style: buttonStyle,
                  child: const Text('E')),
              TextButton(
                  onPressed: () {model.addCharToTextField('R');},
                  style: buttonStyle,
                  child: const Text('R')),
              TextButton(
                  onPressed: () {model.addCharToTextField('T');},
                  style: buttonStyle,
                  child: const Text('T')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('Y');
                  },
                  style: buttonStyle,
                  child: const Text('Y')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('U');
                  },
                  style: buttonStyle,
                  child: const Text('U')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('I');
                  },
                  style: buttonStyle,
                  child: const Text('I')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('O');
                  },
                  style: buttonStyle,
                  child: const Text('O')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('P');
                  },
                  style: buttonStyle,
                  child: const Text('P')),
        ],
        [
          TextButton(
                  onPressed: () {model.addCharToTextField('A');},
                  style: buttonStyle,
                  child: const Text('A')),
              TextButton(
                  onPressed: () {model.addCharToTextField('S');},
                  style: buttonStyle,
                  child: const Text('S')),
              TextButton(
                  onPressed: () {model.addCharToTextField('D');},
                  style: buttonStyle,
                  child: const Text('D')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('F');
                  },
                  style: buttonStyle,
                  child: const Text('F')),
              TextButton(
                  onPressed: () {model.addCharToTextField('G');},
                  style: buttonStyle,
                  child: const Text('G')),
              TextButton(
                  onPressed: () {model.addCharToTextField('H');},
                  style: buttonStyle,
                  child: const Text('H')),
              TextButton(
                  onPressed: () {model.addCharToTextField('J');},
                  style: buttonStyle,
                  child: const Text('J')),
              TextButton(
                  onPressed: () {model.addCharToTextField('K');},
                  style: buttonStyle,
                  child: const Text('K')),
              TextButton(
                  onPressed: () {model.addCharToTextField('L');},
                  style: buttonStyle,
                  child: const Text('L')),
        ],
        [
          IconButton(
                  onPressed: () {capsButtonTap();},
                  style: buttonStyle,
                  icon: const Icon(CustomMathIcons.shift_lock,size: 20)),
              TextButton(
                  onPressed: () {model.addCharToTextField('Z');},
                  style: buttonStyle,
                  child: const Text('Z')),
              TextButton(
                  onPressed: () {model.addCharToTextField('X');},
                  style: buttonStyle,
                  child: const Text('X')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('C');
                  },
                  style: buttonStyle,
                  child: const Text('C')),
              TextButton(
                  onPressed: () {model.addCharToTextField('V');},
                  style: buttonStyle,
                  child: const Text('V')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('B');
                  },
                  style: buttonStyle,
                  child: const Text('B')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('N');
                  },
                  style: buttonStyle,
                  child: const Text('N')),
              TextButton(
                  onPressed: () {
                    model.addCharToTextField('M');
                  },
                  style: buttonStyle,
                  child: const Text('M')),
        ]
      ];
    }
    return KeyboardPage(pageRows: pageRows); 
  }
}