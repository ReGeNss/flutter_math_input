import 'package:flutter/material.dart';
import '../services/text_field_handle_and_create.dart';
import '../widgets/supportive_widges/relayed_positioned.dart';
import '../widgets/supportive_widges/widget_dynamic_size_wrapper.dart';
import 'math_construction.dart';

class Log extends DefaultMathConstruction{
  Log(super.builder);

  @override
  MathConstructionKey get key => LogKey();
  
  @override
  MathConstructionWidgetData createConstruction() {
    final addictionalField = builder.createTextField();
    final argField = builder.createTextField();
    final baseField = builder.createTextField(
      replaceOldFocus: true,
      isActive: true,
      format: TextFieldFormat.small
    );
    builder.markAsGroup(baseField, argField);
    final baseFieldKey = GlobalKey();
    final argFieldKey = GlobalKey();
    final logWidget = WidgetDynamicSizeWrapper(
      key: builder.getKey(LogKey()),
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
    return MathConstructionWidgetData(construction: logWidget, addictionalWidget: addictionalField);
  }
}

class LogKey extends GroupMathConstructionKey{
  @override
  List<String> get katexExp => ['\\log_{','} ',''];
  @override
  List<int> get fieldsLocation => [1,2];
}

