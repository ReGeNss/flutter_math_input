import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/function_page.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/greek_symbols_scrool.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/latin_alphabet_page.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/standart_numbers_page.dart';
import 'package:provider/provider.dart';

const countOfButtonsInRow = 6;

final defaultButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(
      const Color.fromRGBO(211, 211, 211, 0.3),
    ),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));

final defalultOverlayButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.cyan[100]),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.cyanAccent)));

final defalutButtonWithOverlayStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(
      const Color.fromRGBO(211, 211, 211, 0.3),
    ),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.cyanAccent)));

// TODO: extract to separate file
class MathKeyboard {
  final BuildContext context;
  late final MathController keyboardProperties;
  MathKeyboard({required this.context}){
    try{
      keyboardProperties = context.read<MathController>();
    } on ProviderNotFoundException {
      throw Exception('MathKeyboardModel not found. Please add provide MathKeyboardModel to your widget tree.');
    }
  }

  Widget buildKeyboard(StateSetter setState) {
    throw UnimplementedError('The buildKeyboard method must be overridden in the child class');
  }

  void show() {
    try{
      Scaffold.of(context).showBottomSheet(
        (context) => StatefulBuilder(
          builder: (context, setState) => buildKeyboard(setState),
        ),
      );
    } catch (e) {
      throw Exception('Something went wrong. Tap delete button to clear the input');
    }
  }
}

class BasicMathKeyboard extends MathKeyboard {
  static BasicMathKeyboard? _instance;

  final double height;
  final double width;
  final EdgeInsets padding;
  final double spacing;
  final Color backgroundColor;
  final ButtonStyle? buttonsStyle;
  final ButtonStyle? buttonWithOverlayStyle;
  final ButtonStyle? overlayButtonStyle;
  final int floatButtonOverlayDuration;
  final double iconSize;
  final TextStyle? textStyle;
  late final List<Widget> _keyboardFormat = [
    NumbersPageWidget(
        buttonStyle: buttonsStyle,
        buttonWithOverlayStyle: buttonWithOverlayStyle,
        overlayButtonStyle: overlayButtonStyle,
        textStyle: textStyle,
        iconSize: iconSize,
        keyboardPaddings: keyboardPaddings,
        keyboardSpacing: spacing,
        keyboardProperties: keyboardProperties,
        floatButtonOverlayDuration: floatButtonOverlayDuration,
      ),
      FunctionPageWidget(
        buttonStyle: buttonsStyle,
        iconSize: iconSize,
        textStyle: textStyle,
        keyboardPaddings: keyboardPaddings,
        keyboardSpacing: spacing,
        keyboardProperties: keyboardProperties
      ),
      LatinAlphabetPageWidget(
        buttonStyle: buttonsStyle,
        iconSize: iconSize,
        textStyle: textStyle,
        keyboardPaddings: keyboardPaddings,
        keyboardSpacing: spacing,
        keyboardProperties: keyboardProperties
      ),
  ];
  late final double keyboardPaddings = padding.left + padding.right;
  int _selectedKeyboardFormat = 0;

  BasicMathKeyboard._({
    required this.height,
    required this.width,
    required this.padding,
    required this.spacing,
    required this.backgroundColor,
    this.buttonsStyle,
    this.buttonWithOverlayStyle,
    this.overlayButtonStyle,
    required this.iconSize,
    this.textStyle,
    required super.context,
    required this.floatButtonOverlayDuration,
  }); 

  factory BasicMathKeyboard({
    double height = 350,
    double width = double.infinity,
    EdgeInsets padding = const EdgeInsets.all(10),
    double spacing = 5,
    Color backgroundColor = Colors.white,
    ButtonStyle? buttonsStyle,
    ButtonStyle? buttonWithOverlayStyle,
    ButtonStyle? overlayButtonStyle,
    double iconSize = 30,
    TextStyle? textStyle,
    BuildContext? context,
    int floatButtonOverlayDuration = 2,
  }) {
    if(_instance == null && context == null ) {
      throw Exception('In first call of BasicMathKeyboard you must provide context');
    }
    _instance ??= BasicMathKeyboard._(
      context: context!,
      height: height,
      width: width,
      padding: padding,
      spacing: spacing,
      backgroundColor: backgroundColor,
      buttonsStyle: buttonsStyle,
      buttonWithOverlayStyle: buttonWithOverlayStyle,
      overlayButtonStyle: overlayButtonStyle,
      iconSize: iconSize, 
      textStyle: textStyle,
      floatButtonOverlayDuration: floatButtonOverlayDuration,
    );
    return _instance!;
  }

  @override
  Widget buildKeyboard(StateSetter setState) {
    
    return Container(
      color: backgroundColor,
      height: height,
      width: width,
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                spacing: spacing,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavigationButton(
                    onPressed: () => keyboardProperties.selectBackFocus(),
                    icon: Icons.arrow_back,
                  ),
                  _buildNavigationButton(
                    onPressed: () => keyboardProperties.selectNextFocus(),
                    icon: Icons.arrow_forward,
                  ),
                  _buildNavigationButton(
                    onPressed: () {
                      _selectedKeyboardFormat = 0;
                      setState(() {});
                    },
                    icon: Icons.pin_outlined,
                  ),
                  _buildNavigationButton(
                    onPressed: () {
                      _selectedKeyboardFormat = 1;
                      setState(() {});
                    },
                    icon: Icons.functions_outlined,
                  ),
                  _buildNavigationButton(
                    onPressed: () {
                      _selectedKeyboardFormat = 2;
                      setState(() {});
                    },
                    icon: Icons.abc_outlined,
                  ),
                  _buildNavigationButton(
                    onPressed: () => keyboardProperties.backspaceButtonTap(),
                    icon: Icons.backspace_outlined,
                  ),
                  _buildNavigationButton(
                    onPressed: () => keyboardProperties.deleteAllButtonTap(),
                    icon: Icons.delete_outline,
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing),
            Expanded(
              child: ScroolGreekSymbolsWidget(
                keyboardProperties: keyboardProperties,
                buttonStyle: buttonsStyle,
                textStyle: textStyle,
                iconSize: iconSize,
                keyboardSpacing: spacing,
                keyboardPadding: keyboardPaddings,
              ),
            ),
            SizedBox(height: spacing),
            Expanded(
              flex: 4,
              child: _keyboardFormat[_selectedKeyboardFormat],
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildNavigationButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Expanded(
      child: SizedBox(
        height: double.infinity,
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: textStyle?.color),
          style: buttonsStyle ?? defaultButtonStyle,
        ),
      ),
    );
  }

}

class KeyboardPageWidget extends StatelessWidget {
  const KeyboardPageWidget({
    super.key,
    required this.pageRows,
    required this.keyboardPaddings,
    required this.keyboardSpacing,
  });

  final List<List<Widget>> pageRows;
  final double keyboardPaddings;
  final double keyboardSpacing;

  @override
  Widget build(BuildContext context) {
    final rows = pageRows.map((row) {
      final fullWidth = MediaQuery.of(context).size.width;
      final buttonWidth =
          (fullWidth - keyboardPaddings - (row.length - 1) * keyboardSpacing) /
              row.length;
      return Expanded(
        child: Row(
          spacing: keyboardSpacing,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: row
              .map((button) => SizedBox(
                    height: double.infinity,
                    width: buttonWidth,
                    child: button,
                  ))
              .toList(),
        ),
      );
    }).toList();

    return Column(
      spacing: keyboardSpacing,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rows,
    );
  }
}

