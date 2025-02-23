import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/function_page.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/greek_symbols_scrool.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/latin_alphabet_page.dart';
import 'package:math_keyboard/widgets/keyboardPages.dart/standart_numbers_page.dart';
import 'package:provider/provider.dart';

const double iconSize = 30;
final buttonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(
      const Color.fromRGBO(211, 211, 211, 0.3),
    ),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.greenAccent)));

final overlayButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.cyan[100]),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.cyanAccent)));

final buttonWithOverlayStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(
      const Color.fromRGBO(211, 211, 211, 0.3),
    ),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    side: WidgetStateProperty.all(const BorderSide(color: Colors.cyanAccent)));

class KeyboardBottomSheet{
  final List<Widget> keyboardFormat = const [NumbersPageWidget(),FunctionPageWidget(),LatinAlphabetPageWidget()];
  int selectedKeyboardFormat = 0; 
  PersistentBottomSheetController keyboardBottomSheetWidget(BuildContext context) {
    final model = context.read<KeyboardModel>(); 
    return Scaffold.of(context).showBottomSheet((BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return SizedBox(
          height: 350,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Expanded(
                        child: SizedBox(
                          height: 50,
                          child: IconButton(
                          onPressed: () {
                            context.read<KeyboardModel>().selectBackFocus();
                          },
                          icon: const Icon(Icons.arrow_back),
                          style: buttonStyle,
                          ),
                        ),
                        ),
                        Expanded(
                        child: SizedBox(
                          height: 50,
                          child: IconButton(
                          onPressed: () {
                            context.read<KeyboardModel>().selectNextFocus();
                          },
                          icon: const Icon(Icons.arrow_forward),
                          style: buttonStyle,
                          ),
                        ),
                        ),
                        Expanded(
                        child: SizedBox(
                          height: 50,
                          child: IconButton(
                          onPressed: () {
                            selectedKeyboardFormat = 0;
                            setState(() {});
                          },
                          icon: const Icon(Icons.pin_outlined),
                          style: buttonStyle,
                          ),
                        ),
                        ),
                        Expanded(
                        child: SizedBox(
                          height: 50,
                          child: IconButton(
                          onPressed: () {
                            selectedKeyboardFormat = 1;
                            setState(() {});
                          },
                          icon: const Icon(Icons.functions_outlined),
                          style: buttonStyle,
                          ),
                        ),
                        ),
                        Expanded(
                        child: SizedBox(
                          height: 50,
                          child: IconButton(
                          onPressed: () {
                            selectedKeyboardFormat = 2;
                            setState(() {});
                          },
                          icon: const Icon(Icons.abc_outlined),
                          style: buttonStyle,
                          ),
                        ),
                        ),
                        Expanded(
                        child: SizedBox(
                          height: 50,
                          child: IconButton(
                          onPressed: () {
                            model.backspaceButtonTap();
                          },
                          icon: const Icon(Icons.backspace_outlined),
                          style: buttonStyle,
                          ),
                        ),
                        ),
                        Expanded(
                        child: SizedBox(
                          height: 50,
                          child: IconButton(
                          onPressed: () {
                            model.deleteAllButtonTap();
                          },
                          icon: const Icon(Icons.delete_outline),
                          style: buttonStyle,
                          ),
                        ),
                        )
                        ],
                      ),
                    ),
                    const Expanded(
                      child: scroolGreekSymbolsWidget(),
                    ),
                    const SizedBox(
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

final keyboardPaddings = 20;
final double keyboardSpacing = 5;


class KeyboardPage extends StatelessWidget {
  const KeyboardPage({super.key, required this.pageRows});
  
  final List<List<Widget>> pageRows;

  @override
  Widget build(BuildContext context) {
    final rows = pageRows
        .map((row) {
          final fullWidth = MediaQuery.of(context).size.width;
          final buttonWidth = (fullWidth - keyboardPaddings - (row.length -1) * keyboardSpacing) / row.length;
          return Expanded(
            child: Row(
                spacing: keyboardSpacing,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row
                    .map((button) =>
                        SizedBox(height: double.infinity, width: buttonWidth, child: button))
                    .toList()));})
        .toList();
    return Column(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rows,
    );
  }
}
