import 'package:flutter/material.dart';
import '../../services/math_constructions_building.dart';
import '../../math_constructions/index.dart';

extension NamedFunction on MathConstructionsBuilding{
  MathConstructionData createNamedFunctionWidget(String functionName, MathConstruction type) {
    final addictinalTextFiled = textFieldService.createTextField(
      isReplaceOperation: false
    );
    final textFieldWidget = textFieldService.createTextField(
      isReplaceOperation: true,
      isActiveTextField: true,
    );
    final widget = SizedBox(
      key: getKey(type),
      child: Row(
        children: [
          Text(
            functionName,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(
            width: 3,
          ),
          textFieldWidget,
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
    return MathConstructionData(construction: widget, addictionalWidget: addictinalTextFiled);
  }
}