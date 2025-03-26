import 'package:flutter/material.dart';
import '../services/math_constructions_building.dart';
import 'math_construction.dart';

class Backets extends DefaultMathConstruction{
  Backets(super.builder);

  @override
  MathConstructionKey get key => BacketsKey();

  @override
  MathConstructionWidgetData createConstruction() {
    final textFieldWidget = builder.createTextField(
      replaceOldFocus: true,
      isActive: true,
    );
    final adictionalField = builder.createTextField();
    final backetsWidget = _BacketsWidget(key: builder.getKey(BacketsKey()) ,textFieldWidget: textFieldWidget);
    return MathConstructionWidgetData(construction: backetsWidget, addictionalWidget: adictionalField);
  }  
}

class BacketsKey extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => ['\\left(','\\right)'];
}

class _BacketsWidget extends StatefulWidget implements SingleChildConstruction {
  _BacketsWidget({
    super.key,
    required this.textFieldWidget,
  });
  final Widget textFieldWidget;
  @override
  Widget? child;

  @override
  State<_BacketsWidget> createState() => _BacketsWidgetState();
}

class _BacketsWidgetState extends State<_BacketsWidget> {
  @override
  Widget build(BuildContext context) {
    widget.child ??= Row(
        children: [
          widget.textFieldWidget,
        ],
      );
    return Row(
      children: [
        const Text('(',style: TextStyle(fontSize: 20),),
        widget.child!,
        const Text(')',style: TextStyle(fontSize: 20),)
      ],
    );
  }
}