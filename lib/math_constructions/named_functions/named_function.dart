import 'package:flutter/material.dart';
import '../index.dart';

class NamedFunction extends DefaultMathConstruction{
  NamedFunction(super.builder, {
    required this.constructionKey,
    required this.functionName,
  });
  MathConstructionKey constructionKey;
  String functionName; 

  @override
  MathConstructionKey get key => constructionKey;

  @override
  MathConstructionWidgetData createConstruction() {
    final addictinalTextFiled = builder.createTextField(
      replaceOldFocus: false
    );
    final textFieldWidget = builder.createTextField(
      replaceOldFocus: true,
      isActive: true,
    );
    final widget = SizedBox(
      key: builder.getKey(key),
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
    return MathConstructionWidgetData(construction: widget, addictionalWidget: addictinalTextFiled);
  }
}