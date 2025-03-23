import 'package:flutter/material.dart';
import '../../services/math_constructions_building.dart';
import '../../services/text_field_handle_and_create.dart';
import '../supportive_widges/relayed_positioned.dart';
import '../supportive_widges/widget_dynamic_size_wrapper.dart';

extension Exp on MathConstructionsBuilding{
  MathConstructionData createExpWidget(Widget baseWidget, TextFieldData baseFieldData) {
    final expGlobalKey = GlobalKey();
    final baseGlobalKey = GlobalKey();
    final addictionalTextField = textFieldService.createTextField(
      isReplaceOperation: false,
      isActiveTextField: false,
      selectedTextFieldFormat: TextFieldFormat.standart);
    final textField = textFieldService.createTextField(
      isReplaceOperation: false,
      isActiveTextField: true,
      selectedTextFieldFormat: TextFieldFormat.small);
    textFieldService.markAsGrop(baseFieldData, textField);
    final widget = WidgetDynamicSizeWrapper(
      defaultHeight: 50,
      connectedKeysToHeight: [],
      connectedKeysToWidth: [expGlobalKey, baseGlobalKey],
      wrappedWidget: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            key: baseGlobalKey,
            left: 0,
            bottom: 0,
            child: Row(
              children: [
                baseWidget,
              ],
            ),
          ),
          RelayedPositioned(
            key: expGlobalKey,
            right:  10,
            offsetByHeight: RelayedPositionedType.fromBottom,
            connectedWidgetKeys: [baseGlobalKey],
            widgetToWrap: Row(
              key: getKey(ElementsType.exponentiationElement),
              children: [
                textField,
              ],
            ),
          )
        ],
      ),
    );
    return MathConstructionData(construction: widget, addictionalWidget: addictionalTextField);
  }
}