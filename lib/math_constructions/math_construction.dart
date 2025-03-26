import 'package:flutter/material.dart';
import '../parsers/formulas_tree_parsers.dart';
import '../services/math_constructions_building.dart';
import '../services/text_field_handle_and_create.dart';

abstract interface class MathConstruction{
  final MathConstructionsBuilding builder;

  MathConstruction(this.builder);
  
  MathConstructionWidgetData createConstruction();

  MathConstructionKey get key; 
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

abstract class MathConstructionKey {
  List<String> get katexExp;
}

abstract class SimpleMathConstructionKey extends MathConstructionKey{}

abstract class GroupMathConstructionKey extends MathConstructionKey{
  List<int> get fieldsLocation;
} 

class MathConstructionWidgetData {
  final Widget? addictionalWidget;
  final Widget construction;

  MathConstructionWidgetData({required this.construction, this.addictionalWidget});
}
