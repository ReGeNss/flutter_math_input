import 'package:flutter/material.dart';
import '../../services/math_constructions_building.dart';
import '../../services/text_field_handle_and_create.dart';
import '../supportive_widges/relayed_positioned.dart';
import '../supportive_widges/widget_dynamic_size_wrapper.dart';

extension Integral on MathConstructionsBuilding{
  MathConstructionData createIntegralWidget() {
    final adictionalField = textFieldService.createTextField(
        isReplaceOperation: false,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.standart);
    final startPointField = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.small);
    final derevativeField = textFieldService.createTextField(
        isReplaceOperation: false,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.standart);
    final argFieldWidget = textFieldService.createTextField(
        isReplaceOperation: false,
        selectedTextFieldFormat: TextFieldFormat.standart);
    final finishPointField = textFieldService.createTextField(
        isReplaceOperation: false,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.small);
    final argumentKey = GlobalKey();
    final finishPointKey = GlobalKey();
    final derevativeKey = GlobalKey();
    textFieldService.markAsGrop(startPointField, derevativeField);
    final integralWidget = WidgetDynamicSizeWrapper(
      key: getKey(ElementsType.integralElement),
      connectedKeysToHeight: [],
      connectedKeysToWidth: [finishPointKey, argumentKey, derevativeKey],
      defaultHeight: 60,
      defaultWidth: 25,
      wrappedWidget: Stack(
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
                widgetToWrap: ArgumentWidget(argumentWidget: argFieldWidget)),
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
    return MathConstructionData(construction: integralWidget, addictionalWidget: adictionalField);
  }
}

class ArgumentWidget extends StatefulWidget implements SingleChildConstruction {
  ArgumentWidget({super.key, required this.argumentWidget});
  final Widget argumentWidget;
  @override
  Widget? child;
  
  @override
  State<ArgumentWidget> createState() => _ArgumentWidgetState();
}

class _ArgumentWidgetState extends State<ArgumentWidget> {
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