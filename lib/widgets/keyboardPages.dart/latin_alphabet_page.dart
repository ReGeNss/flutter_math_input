import 'package:flutter/material.dart';
import 'package:math_keyboard/custom_math_icons_icons.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:provider/provider.dart';

const latinAlphabetRows = [
  ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
  ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
  ['shift', 'z', 'x', 'c', 'v', 'b', 'n', 'm']
];
final lastRow = latinAlphabetRows.length - 1;
final shiftButtonLocation = 0;

class LatinAlphabetPageWidget extends StatefulWidget {
  const LatinAlphabetPageWidget({
    super.key, 
    this.buttonStyle, 
    this.iconSize = 30, 
    this.textStyle,
    required this.keyboardPaddings,
    required this.keyboardSpacing,
  });
 
  final ButtonStyle? buttonStyle;
  final double iconSize;
  final TextStyle? textStyle;
  final double keyboardPaddings;
  final double keyboardSpacing;

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
    final model = context.read<MathKeyboardModel>();
    late final List<List<Widget>> pageRows = []; 
    if(!isCapsActive) {
      for(final row in latinAlphabetRows){
        pageRows.add(row
            .map((char) => TextButton(
                onPressed: () => model.addCharToTextField(char),
                style: widget.buttonStyle ?? defaultButtonStyle,
                child: Text(char, style: widget.textStyle)))
            .toList());
      }
    }else{
      for(final row in latinAlphabetRows){  
        pageRows.add(row
            .map((char) => TextButton(
                onPressed: () => model.addCharToTextField(char.toUpperCase()),
                style: widget.buttonStyle ?? defaultButtonStyle,
                child: Text(char.toUpperCase(), style: widget.textStyle)))
            .toList());
      };
    }
    pageRows[lastRow][shiftButtonLocation] = TextButton(
      onPressed: capsButtonTap,
      style: widget.buttonStyle ?? defaultButtonStyle, 
      child: Icon(isCapsActive ? CustomMathIcons.shift_lock : CustomMathIcons.shift, color: widget.textStyle?.color, size: 20),
    );
    return KeyboardPageWidget(pageRows: pageRows, keyboardPaddings: widget.keyboardPaddings, keyboardSpacing: widget.keyboardSpacing); 
  }
}