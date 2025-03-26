import 'package:flutter/material.dart';
import '../services/math_constructions_building.dart';
import '../services/text_field_handle_and_create.dart';
import '../widgets/supportive_widges/relayed_positioned.dart';
import '../widgets/supportive_widges/widget_dynamic_size_wrapper.dart';
import 'math_construction.dart';

class Integral extends DefaultMathConstruction{
  Integral(super.builder);

  @override
  MathConstructionKey get key => IntegralKey();

  @override
  MathConstructionWidgetData createConstruction() {
    final adictionalField = builder.createTextField(format: TextFieldFormat.standart);
    final startPointField = builder.createTextField(
        replaceOldFocus: true,
        isActive: true,
        format: TextFieldFormat.small);
    final derevativeField = builder.createTextField(format: TextFieldFormat.standart);
    final argFieldWidget = builder.createTextField(format: TextFieldFormat.standart);
    final finishPointField = builder.createTextField(format: TextFieldFormat.small);
    final argumentKey = GlobalKey();
    final finishPointKey = GlobalKey();
    final derevativeKey = GlobalKey();
    builder.markAsGroup(startPointField, derevativeField);
    final integralWidget = WidgetDynamicSizeWrapper(
      key: builder.getKey(IntegralKey()),
      connectedKeysToHeight: [],
      connectedKeysToWidth: [finishPointKey, argumentKey, derevativeKey],
      defaultHeight: 60,
      defaultWidth: 25,
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            const Positioned(
              left: 0,
              child: Center(
                  child: Text(
                '∫',
                style: TextStyle(fontSize: 30),
              )),
            ),
      
            Positioned(bottom: -5, left: 5, child: Row(
              children: [
                startPointField,
              ],
            )),
            Positioned(key: finishPointKey, top: -10, left: 10, child: Row(
              children: [
                finishPointField,
              ],
            )),
            RelayedPositioned(
                key: argumentKey,
                connectedWidgetKeys: [finishPointKey],
                offsetByWidth: RelayedPositionedType.fromLeft,
                left: 10,
                widgetToWrap: _ArgumentWidget(argumentWidget: argFieldWidget)),
            RelayedPositioned(
              left: 10,
              offsetByWidth: RelayedPositionedType.fromLeft,
              connectedWidgetKeys: [finishPointKey, argumentKey],
              widgetToWrap: Text(
                'd',
                style: TextStyle(fontSize: 20),
              ),
            ),
            RelayedPositioned(
              key: derevativeKey,
              left: 20,
              widgetToWrap: derevativeField,
              connectedWidgetKeys: [argumentKey, finishPointKey],
              offsetByWidth: RelayedPositionedType.fromLeft,
            ),
          ],
        ),
    );
    return MathConstructionWidgetData(construction: integralWidget, addictionalWidget: adictionalField);
  } 
}

class IntegralKey extends GroupMathConstructionKey{
  @override
  List<String> get katexExp => ['\\int_{','}^{','} ',' d',''];

  @override
  List<int> get fieldsLocation => [1, 2, 3, 5];
}

class _ArgumentWidget extends StatefulWidget implements SingleChildConstruction {
  _ArgumentWidget({required this.argumentWidget});
  final Widget argumentWidget;
  @override
  Widget? child;
  
  @override
  State<_ArgumentWidget> createState() => _ArgumentWidgetState();
}

class _ArgumentWidgetState extends State<_ArgumentWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.child != null) {
      return widget.child!;
    }
    widget.child = Row(
      children: [
        widget.argumentWidget,
      ],
    );
    return widget.child!;
  }
}