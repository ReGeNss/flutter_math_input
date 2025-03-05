import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/function_page.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/greek_symbols_scrool.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/latin_alphabet_page.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/standart_numbers_page.dart';
import 'package:provider/provider.dart';

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
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rows,
    );
  }
}

class MathKeyboard {
  static MathKeyboard? _instance;

  final double height;
  final double width;
  final EdgeInsets padding;
  final double spacing;
  final Color backgroundColor;
  final ButtonStyle? buttonsStyle;
  final ButtonStyle? buttonWithOverlayStyle;
  final ButtonStyle? overlayButtonStyle;
  final double keyboardPaddings;
  final double iconSize;
  final TextStyle? textStyle;
  final List<Widget> _keyboardFormat = [];
  int _selectedKeyboardFormat = 0;

  MathKeyboard._({
    this.height = 350,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(10),
    this.spacing = 5,
    this.backgroundColor = Colors.white,
    this.buttonsStyle,
    this.buttonWithOverlayStyle,
    this.overlayButtonStyle,
    this.keyboardPaddings = 20,
    this.iconSize = 30,
    this.textStyle,
  }) {
    _initKeyboardFormat();
  }

  void _initKeyboardFormat() {
    _keyboardFormat.addAll([
      NumbersPageWidget(
        buttonStyle: buttonsStyle,
        buttonWithOverlayStyle: buttonWithOverlayStyle,
        overlayButtonStyle: overlayButtonStyle,
        textStyle: textStyle,
        iconSize: iconSize,
        keyboardPaddings: keyboardPaddings,
        keyboardSpacing: spacing,
      ),
      FunctionPageWidget(
        buttonStyle: buttonsStyle,
        iconSize: iconSize,
        textStyle: textStyle,
        keyboardPaddings: keyboardPaddings,
        keyboardSpacing: spacing,
      ),
      LatinAlphabetPageWidget(
        buttonStyle: buttonsStyle,
        iconSize: iconSize,
        textStyle: textStyle,
        keyboardPaddings: keyboardPaddings,
        keyboardSpacing: spacing,
      ),
    ]);
  }

  factory MathKeyboard({
    double height = 350,
    double width = double.infinity,
    EdgeInsets padding = const EdgeInsets.all(10),
    double spacing = 5,
    Color backgroundColor = Colors.white,
    ButtonStyle? buttonsStyle,
    ButtonStyle? buttonWithOverlayStyle,
    ButtonStyle? overlayButtonStyle,
    double keyboardPaddings = 20,
    double iconSize = 30,
    TextStyle? textStyle,
  }) {
    _instance ??= MathKeyboard._(
      height: height,
      width: width,
      padding: padding,
      spacing: spacing,
      backgroundColor: backgroundColor,
      buttonsStyle: buttonsStyle,
      buttonWithOverlayStyle: buttonWithOverlayStyle,
      overlayButtonStyle: overlayButtonStyle,
      keyboardPaddings: keyboardPaddings,
      iconSize: iconSize, 
      textStyle: textStyle,
    );
    return _instance!;
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

  Widget _buildKeyboardContent(BuildContext context, StateSetter setState) {
    final model = context.read<MathKeyboardModel>();

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
                    onPressed: () => model.selectBackFocus(),
                    icon: Icons.arrow_back,
                  ),
                  _buildNavigationButton(
                    onPressed: () => model.selectNextFocus(),
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
                    onPressed: () => model.backspaceButtonTap(),
                    icon: Icons.backspace_outlined,
                  ),
                  _buildNavigationButton(
                    onPressed: () => model.deleteAllButtonTap(),
                    icon: Icons.delete_outline,
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing),
            Expanded(
              child: ScroolGreekSymbolsWidget(
                buttonStyle: buttonsStyle,
                textStyle: textStyle,
                iconSize: iconSize,
                keyboardSpacing: spacing,
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

  void showKeyboard(BuildContext context) {
    try{
      context.read<MathKeyboardModel>();
    } on ProviderNotFoundException {
      throw Exception('MathKeyboardModel not found. Please add provide MathKeyboardModel to your widget tree.');
    } catch (e) {
      throw Exception('Something went wrong. Tap delete button to clear the input');
    }
    Scaffold.of(context).showBottomSheet(
      (context) => StatefulBuilder(
        builder: (context, setState) => _buildKeyboardContent(context, setState),
      ),
    );
  }
}