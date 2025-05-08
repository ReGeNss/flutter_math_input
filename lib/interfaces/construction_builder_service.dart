import 'package:flutter/material.dart';
import '../services/index.dart';
import 'index.dart';

abstract class ConstructionBuilderService {
  void createComplicatedConstruction(
    ComplicatedMathConstruction Function(
      MathConstructionsBuilder, {
      required TextFieldHandleAndCreateService textFieldService,
      required ParsedWidgetsData parsingResults,
      required List<Widget> widgetTree,
    }) constructionFactory,
  );

  void createSimpleConstruction(
    DefaultMathConstruction Function(MathConstructionsBuilder) constructionFactory,
  );

  void createCharWidgets(String char);
}