import 'package:flutter/material.dart';
import 'math_construction.dart';

class UndefinitIntegral extends DefaultMathConstruction{
  UndefinitIntegral(super.builder);
  
    @override
    MathConstructionKey get key => UndefinitIntegralConstruction();
  
    @override
    MathConstructionWidgetData createConstruction() {
      final argFieldWidget = builder.createTextField(
        replaceOldFocus: true, isActive: true);
    final addictionalField = builder.createTextField();
    final derevativeField = builder.createTextField();
    builder.markAsGroup(argFieldWidget, derevativeField); 
    final integralWidget = Row(
      key: builder.getKey(UndefinitIntegralConstruction()),
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
            derevativeField,
          ],
        ),
      ],
    );
    return MathConstructionWidgetData(construction: integralWidget, addictionalWidget: addictionalField);
    }
}

class UndefinitIntegralConstruction extends GroupMathConstructionKey{
  @override
  List<String> get katexExp => ['\\int ',' d',''];
  @override
  List<int> get fieldsLocation => [1, 3];
}