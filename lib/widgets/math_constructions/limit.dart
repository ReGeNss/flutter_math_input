import 'package:flutter/material.dart';
import '../../services/math_constructions_building.dart';
import '../../services/text_field_handle_and_create.dart';
import '../supportive_widges/relayed_positioned.dart';
import '../supportive_widges/widget_dynamic_size_wrapper.dart';

extension Limit on MathConstructionsBuilding{ 
  MathConstructionData createLimitWidget() {
    final addictionalField = textFieldService.createTextField(
        isReplaceOperation: false);
    final argField = textFieldService.createTextField(
        isReplaceOperation: false);
    final firstDownField = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        selectedTextFieldFormat: TextFieldFormat.small);
    final secondDownField = textFieldService.createTextField(
        isReplaceOperation: false,
        selectedTextFieldFormat: TextFieldFormat.small);
    final argWidgetKey = GlobalKey();
    final firstDownFieldKey = GlobalKey();
    final secondDownFieldKey = GlobalKey();
    textFieldService.markAsGrop(firstDownField, argField); 
    final limitWidget = WidgetDynamicSizeWrapper(
          connectedKeysToHeight: [],
          defaultHeight: 50,
          defaultWidth: 50,
          connectedKeysToWidth: [firstDownFieldKey, secondDownFieldKey, argWidgetKey],
          key: getKey(ElementsType.limitElement),
          wrappedWidget: Stack(
            clipBehavior: Clip.none,
            children: [
              RelayedPositioned(
                left: 0,
                divideOffset: true,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey,secondDownFieldKey],
                widgetToWrap: SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      'lim',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              RelayedPositioned(
                key: argWidgetKey,
                left: 45,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey, secondDownFieldKey],
                widgetToWrap: argField,
              ),
              Positioned(
                key: firstDownFieldKey,
                bottom: -20,
                left: 0,
                child: Row(
                  children: [firstDownField],
                ),
              ),
              RelayedPositioned(
                bottom: -20, 
                left: 5,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey],
                widgetToWrap: Icon(Icons.arrow_forward_outlined)
              ),
              RelayedPositioned(
                key: secondDownFieldKey,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey],
                bottom: -20,
                left: 40,
                widgetToWrap: secondDownField,
              ),
            ],
          ),
        );
    return MathConstructionData(construction: limitWidget, addictionalWidget: addictionalField);
  }
}