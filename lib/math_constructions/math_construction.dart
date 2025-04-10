import 'package:flutter/material.dart';
import '../parsers/formulas_tree_parsers.dart';
import '../services/math_constructions_building.dart';
import '../services/text_field_handle_and_create.dart';

abstract interface class MathConstruction{
  final MathConstructionsBuilding builder;

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

abstract class MathConstructionKey {
  static MathConstructionKey getKey(ObjectKey key) {
    return key.value as MathConstructionKey;
  } 
  
  static ObjectKey setKey(MathConstructionKey construction){
    return ObjectKey(construction);
  }

  List<String> get katexExp;
}

abstract class SimpleMathConstructionKey extends MathConstructionKey{}

abstract class GroupMathConstructionKey extends MathConstructionKey{
  List<int> get fieldsLocation;
} 

class MathConstructionWidgetData {
  final Widget? additionalWidget;
  final Widget construction;

  MathConstructionWidgetData({
    required this.construction, 
    this.additionalWidget,
  });
}
