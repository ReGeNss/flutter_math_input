import 'package:flutter/material.dart';
import '../services/math_constructions_building.dart';
import '../services/text_field_handle_and_create.dart';
import '../widgets/supportive_widgets/relayed_positioned.dart';
import '../widgets/supportive_widgets/widget_dynamic_size_wrapper.dart';
import 'math_construction.dart';

class Integral extends DefaultMathConstruction{
  @override
  MathConstructionKey get key => IntegralKey();

  Integral(super.builder);

  @override
  MathConstructionWidgetData createConstruction() {
    final additionalField = builder.createTextField(
      format: TextFieldFormat.standard,
    );
    final startPointField = builder.createTextField(
      replaceOldFocus: true,
      isActive: true,
      format: TextFieldFormat.small,
    );
    final derivativeField = builder.createTextField(
      format: TextFieldFormat.standard,
    );
    final argFieldWidget = builder.createTextField(
      format: TextFieldFormat.standard,
    );
    final finishPointField = builder.createTextField(
      format: TextFieldFormat.small,
    );
    final argumentKey = GlobalKey();
    final finishPointKey = GlobalKey();
    final derivativeKey = GlobalKey();
    builder.markAsGroup(startPointField, derivativeField);
    final integralWidget = WidgetDynamicSizeWrapper(
      key: MathConstructionKey.setKey(IntegralKey()),
      connectedKeysToHeight: const [],
      connectedKeysToWidth: [finishPointKey, argumentKey, derivativeKey],
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
              ),),
            ),
      
            Positioned(bottom: -5, left: 5, child: Row(
              children: [
                startPointField,
              ],
            ),),
            Positioned(key: finishPointKey, top: -10, left: 10, child: Row(
              children: [
                finishPointField,
              ],
            ),),
            RelayedPositioned(
                key: argumentKey,
                connectedWidgetKeys: [finishPointKey],
                offsetByWidth: RelayedPositionedType.fromLeft,
                left: 10,
                widgetToWrap: _ArgumentWidget(argumentWidget: argFieldWidget),),
            RelayedPositioned(
              left: 10,
              offsetByWidth: RelayedPositionedType.fromLeft,
              connectedWidgetKeys: [finishPointKey, argumentKey],
              widgetToWrap: const Text(
                'd',
                style: TextStyle(fontSize: 20),
              ),
            ),
            RelayedPositioned(
              key: derivativeKey,
              left: 20,
              widgetToWrap: derivativeField,
              connectedWidgetKeys: [argumentKey, finishPointKey],
              offsetByWidth: RelayedPositionedType.fromLeft,
            ),
          ],
        ),
    );

    return MathConstructionWidgetData(
      construction: integralWidget, 
      additionalWidget: additionalField,
    );
  } 
}

class IntegralKey extends GroupMathConstructionKey{
  @override
  List<String> get katexExp => [r'\int_{','}^{','} ',' d',''];

  @override
  List<int> get fieldsLocation => [1, 2, 3, 5];
}

class _ArgumentWidget extends StatefulWidget implements SingleChildConstruction{
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
