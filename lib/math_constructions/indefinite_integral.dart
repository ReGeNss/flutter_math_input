import 'package:flutter/material.dart';
import 'math_construction.dart';

class IndefiniteIntegral extends DefaultMathConstruction{
  @override
  MathConstructionKey get key => IndefiniteIntegralBuilder();

  IndefiniteIntegral(super.builder);
  
  
  @override
  MathConstructionWidgetData createConstruction() {
    final argFieldWidget = builder.createTextField(
      replaceOldFocus: true, isActive: true,);
    final additionalField = builder.createTextField();
    final derivativeField = builder.createTextField();
    builder.markAsGroup(argFieldWidget, derivativeField); 
    final integralWidget = Row(
      key: MathConstructionKey.setKey(IndefiniteIntegralBuilder()),
      children: [
        const Text(
          '∫',
          style: TextStyle(fontSize: 25),
        ),
        Row(
          children: [argFieldWidget],
        ),
        const Text(
          'd',
          style: TextStyle(fontSize: 20),
        ),
        Row(
          children: [
            derivativeField,
          ],
        ),
      ],
    );

    return MathConstructionWidgetData(
      construction: integralWidget, 
      additionalWidget: additionalField,
    );
  }
}

class IndefiniteIntegralBuilder extends GroupMathConstructionKey{
  @override
  List<String> get katexExp => [r'\int ',' d',''];
  @override
  List<int> get fieldsLocation => [1, 3];
}
