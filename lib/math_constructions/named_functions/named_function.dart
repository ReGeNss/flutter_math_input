import 'package:flutter/material.dart';
import '../../interfaces/index.dart';
import '../index.dart';

class NamedFunction extends DefaultMathConstruction{
  MathConstructionKey constructionKey;
  String functionName; 
  
  @override
  MathConstructionKey get key => constructionKey;

  NamedFunction(super.builder, {
    required this.constructionKey,
    required this.functionName,
  });

  @override
  MathConstructionWidgetData createConstruction() {
    final additionalTextFiled = builder.createTextField();
    final textFieldWidget = builder.createTextField(
      replaceOldFocus: true,
      isActive: true,
    );
    final widget = SizedBox(
      key: MathConstructionKey.setKey(key),
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
          ),
        ],
      ),
    );

    return MathConstructionWidgetData(
      construction: widget, 
      additionalWidget: additionalTextFiled,
    );
  }
}
