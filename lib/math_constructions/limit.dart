import 'package:flutter/material.dart';
import '../interfaces/index.dart';
import '../services/text_field_handle_and_create.dart';
import '../widgets/supportive_widgets/relayed_positioned.dart';
import '../widgets/supportive_widgets/widget_dynamic_size_wrapper.dart';

class Limit extends DefaultMathConstruction{
  @override
  MathConstructionKey get key => LimitKey();

  Limit(super.builder);

  @override
  MathConstructionWidgetData createConstruction() {
    final additionalField = builder.createTextField();
    final argField = builder.createTextField();
    final firstDownField = builder.createTextField(
      replaceOldFocus: true,
      isActive: true,
      format: TextFieldFormat.small,
    );
    final secondDownField = builder.createTextField(
      format: TextFieldFormat.small,
    );
    final argWidgetKey = GlobalKey();
    final firstDownFieldKey = GlobalKey();
    final secondDownFieldKey = GlobalKey();
    builder.markAsGroup(firstDownField, argField); 
    final limitWidget = WidgetDynamicSizeWrapper(
          connectedKeysToHeight: const [],
          defaultHeight: 50,
          defaultWidth: 50,
          connectedKeysToWidth: [
            firstDownFieldKey, 
            secondDownFieldKey, 
            argWidgetKey,
          ],
          key: MathConstructionKey.setKey(LimitKey()),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              RelayedPositioned(
                left: 0,
                divideOffset: true,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey,secondDownFieldKey],
                widgetToWrap: const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      'lim',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
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
                widgetToWrap: const Icon(Icons.arrow_forward_outlined),
              ),
              RelayedPositioned(
                key: secondDownFieldKey,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey],
                bottom: -20,
                left: 40,
                widgetToWrap: secondDownField,
              ),
              RelayedPositioned(
                key: argWidgetKey,
                left: 45,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey, secondDownFieldKey],
                widgetToWrap: argField,
              ),
            ],
          ),
        );

    return MathConstructionWidgetData(
      construction: limitWidget, 
      additionalWidget: additionalField,
    );
  }
}

class LimitKey extends GroupMathConstructionKey{
  @override
  List<String> get katexExp => [r'\lim_{',r'\to ','} ',''];
  @override
  List<int> get fieldsLocation => [1, 3, 4];
}
