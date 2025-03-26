import 'package:flutter/material.dart';
import '../../services/math_constructions_building.dart';
import '../../math_constructions/index.dart';


extension Backets on MathConstructionsBuilding{
  MathConstructionData createBracketsWidget() {
    final textFieldWidget = textFieldService.createTextField(
      isReplaceOperation: true,
      isActiveTextField: true,
    );
    final adictionalField = textFieldService.createTextField(
      isReplaceOperation: false,
    );
    final backetsWidget = BacketsWidget(textFieldWidget: textFieldWidget);
    return MathConstructionData(construction: backetsWidget, addictionalWidget: adictionalField);
  }
}

class BacketsWidget extends StatefulWidget implements SingleChildConstruction {
  BacketsWidget({
    Key? key,
    required this.textFieldWidget,
  }) : super(key: getKey(BacketsConstuction()));
  final Widget textFieldWidget;
  @override
  Widget? child;

  @override
  State<BacketsWidget> createState() => _BacketsWidgetState();
}

class _BacketsWidgetState extends State<BacketsWidget> {
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