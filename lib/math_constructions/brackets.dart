import 'package:flutter/material.dart';
import '../interfaces/index.dart';

class Brackets extends DefaultMathConstruction{
  @override
  MathConstructionKey get key => BracketsKey();
  
  Brackets(super.builder);

  @override
  MathConstructionWidgetData createConstruction() {
    final textFieldWidget = builder.createTextField(
      replaceOldFocus: true,
      isActive: true,
    );
    final additionalField = builder.createTextField();
    final bracketsWidget = _BracketsWidget(
      key: MathConstructionKey.setKey(BracketsKey()),
      textFieldWidget: textFieldWidget,
    );

    return MathConstructionWidgetData(
      construction: bracketsWidget, 
      additionalWidget: additionalField,
    );
  }  
}

class BracketsKey extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => [r'\left(',r'\right)'];
}

class _BracketsWidget extends StatefulWidget implements SingleChildConstruction{
  _BracketsWidget({required this.textFieldWidget, super.key,});
  final Widget textFieldWidget;
  @override
  Widget? child;

  @override
  State<_BracketsWidget> createState() => _BracketsWidgetState();
}

class _BracketsWidgetState extends State<_BracketsWidget> {
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
        const Text(')',style: TextStyle(fontSize: 20),),
      ],
    );
  }
}
