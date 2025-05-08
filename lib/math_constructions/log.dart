import 'package:flutter/material.dart';
import '../interfaces/index.dart';
import '../services/text_field_handle_and_create.dart';
import '../widgets/supportive_widgets/relayed_positioned.dart';
import '../widgets/supportive_widgets/widget_dynamic_size_wrapper.dart';

class Log extends DefaultMathConstruction{
  @override
  MathConstructionKey get key => LogKey();

  Log(super.builder);

  @override
  MathConstructionWidgetData createConstruction() {
    final additionalField = builder.createTextField();
    final argField = builder.createTextField();
    final baseField = builder.createTextField(
      replaceOldFocus: true,
      isActive: true,
      format: TextFieldFormat.small,
    );
    builder.markAsGroup(baseField, argField);
    final baseFieldKey = GlobalKey();
    final argFieldKey = GlobalKey();
    final logWidget = WidgetDynamicSizeWrapper(
      key: MathConstructionKey.setKey(LogKey()),
      defaultHeight: 50,
      defaultWidth: 40,
      connectedKeysToHeight: const [],
      connectedKeysToWidth: [baseFieldKey, argFieldKey],
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: 0,
            child: SizedBox(
                height: 50,
                child:
                    Center(
                      child: Text('log', style: TextStyle(fontSize: 25)),),
                    ),
          ),
          RelayedPositioned(
            key: baseFieldKey,
            left: 30,
            top: 30,
            widgetToWrap: baseField, 
            connectedWidgetKeys: [baseFieldKey],
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
    
    return MathConstructionWidgetData(
      construction: logWidget, 
      additionalWidget: additionalField,
    );
  }
}

class LogKey extends GroupMathConstructionKey{
  @override
  List<String> get katexExp => [r'\log_{','} ',''];
  @override
  List<int> get fieldsLocation => [1,2];
}
