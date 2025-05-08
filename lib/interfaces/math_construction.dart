import 'package:flutter/material.dart';
import 'index.dart';
import '../services/math_constructions_building.dart';
import '../services/text_field_handle_and_create.dart';

abstract interface class MathConstruction{
  final MathConstructionsBuilder builder;

  MathConstructionKey get key; 

  MathConstruction(this.builder);
  
  MathConstructionWidgetData createConstruction();
}

abstract class DefaultMathConstruction extends MathConstruction{
  DefaultMathConstruction(super.builder);
}

abstract class ComplicatedMathConstruction extends MathConstruction{
  @protected
  final TextFieldHandleAndCreateService textFieldService;
  @protected
  final ParsedWidgetsData parsingResults;
  @protected
  final List<Widget> widgetTree;

  ComplicatedMathConstruction(
    super.builder, {
    required this.textFieldService, 
    required this.parsingResults,
    required this.widgetTree,
  });
}

abstract class SingleChildConstruction{
  Widget? child;
}

abstract class MultiChildConstruction{
  List<Widget> children = [];
}