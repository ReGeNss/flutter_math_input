import 'dart:async';

import 'package:flutter/material.dart';
import '../math_constructions/index.dart';
import '../services/index.dart';
import 'parsed_widgets_data.dart';

abstract class MathController extends ChangeNotifier {
  Stream<String> get katexFormulaStream;

  bool get isFormulaRendered;
  bool get isFormulaUpdated;

  List<Widget> getFormulaWidgets();
  FutureOr<String> getFormulaKaTeX();

  void addCharToTextField(String char);
  
  void createDefaultFunc(
    DefaultMathConstruction Function(MathConstructionsBuilder) constructionFactory,
  );

  void createComplicatedFunc(
    ComplicatedMathConstruction Function(
      MathConstructionsBuilder, {
      required TextFieldHandleAndCreateService textFieldService,
      required ParsedWidgetsData parsingResults,
      required List<Widget> widgetTree,
    }) constructionFactory,
  );

  void createCharWidgets(String char);

  void changeFormulaRenderingState();

  void selectCursorForward();
  void selectCursorBack();

  void backspaceButtonTap();
  void deleteAllButtonTap();
}