import 'package:flutter/material.dart';
import '../../services/math_constructions_building.dart';

extension UndifinitIntegral on MathConstructionsBuilding{
  MathConstructionData createUndefinitIntegralWidget() {
    final argFieldWidget = textFieldService.createTextField(
        isReplaceOperation: true, isActiveTextField: true);
    final addictionalField = textFieldService.createTextField(
      isReplaceOperation: false,
    );
    final derevativeField = textFieldService.createTextField(
        isReplaceOperation: false, performAdictionalTextField: false);
    textFieldService.markAsGrop(argFieldWidget, derevativeField); 
    final integralWidget = Row(
      key: getKey(ElementsType.indefiniteIntegralElement),
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
    return MathConstructionData(construction: integralWidget, addictionalWidget: addictionalField);
  } 
}