import 'package:flutter/widgets.dart';
import '../../services/math_constructions_building.dart';
import '../../services/text_field_handle_and_create.dart';
import '../supportive_widges/relayed_positioned.dart';
import '../supportive_widges/widget_dynamic_size_wrapper.dart';
import '../../math_constructions/index.dart';

extension Log on MathConstructionsBuilding{
    MathConstructionData createLogWidget() {
    final addictionalField = textFieldService.createTextField(
        isReplaceOperation: false);
    final argField =
        textFieldService.createTextField(isReplaceOperation: false);
    final baseField = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        selectedTextFieldFormat: TextFieldFormat.small);
    textFieldService.markAsGrop(baseField, argField);
    final baseFieldKey = GlobalKey();
    final argFieldKey = GlobalKey();
    final logWidget = WidgetDynamicSizeWrapper(
      key: getKey(LogConstruction()),
      defaultHeight: 50,
      defaultWidth: 40,
      connectedKeysToHeight: [],
      connectedKeysToWidth: [baseFieldKey, argFieldKey],
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            child: const SizedBox(
                height: 50,
                child:
                    Center(child: Text('log', style: TextStyle(fontSize: 25)))),
          ),
          RelayedPositioned(
            key: baseFieldKey,
            left: 30,
            top: 30,
            widgetToWrap: baseField, 
            connectedWidgetKeys: [baseFieldKey]
          ),
          RelayedPositioned(
            key: argFieldKey,
            connectedWidgetKeys: [baseFieldKey], 
            widgetToWrap: argField, 
            left: 40,
            offsetByWidth: RelayedPositionedType.fromLeft,
          ),
        
        ],
      ),
    );
    return MathConstructionData(construction: logWidget, addictionalWidget: addictionalField);
  }
}