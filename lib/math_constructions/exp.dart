import 'package:flutter/material.dart';
import '../services/text_field_handle_and_create.dart';
import '../widgets/supportive_widgets/relayed_positioned.dart';
import '../widgets/supportive_widgets/widget_dynamic_size_wrapper.dart';
import 'math_construction.dart';

class Exp extends ComplicatedMathConstruction{
  @override
  MathConstructionKey get key => ExpKey();

  Exp(
    super.builder, {
    required super.textFieldService, 
    required super.parsingResults, 
    required super.widgetTree,
  });

  
  @override
  MathConstructionWidgetData createConstruction() {
    final activeTextFieldController = 
      textFieldService.getActiveTextFieldController();
    TextFieldData baseField; 
    if(activeTextFieldController.text.isNotEmpty){
      baseField = textFieldService.getActiveTextFieldData();
    }
    else{
      if(parsingResults.index != null && parsingResults.index! >= 1){
        parsingResults.index = parsingResults.index! - 1;
        baseField = textFieldService.getPreviousTextFieldDataToActive();
      }else{
        baseField = textFieldService.getActiveTextFieldData();  
      }
    }

    final expGlobalKey = GlobalKey();
    final baseGlobalKey = GlobalKey();
    final additionalTextField = builder.createTextField(
      format: TextFieldFormat.standard,
    );
    final textField = builder.createTextField(
      isActive: true,
      format: TextFieldFormat.small,
    );
    textFieldService.markAsGroup(baseField, textField);
    final baseWidget = parsingResults.widgetData![parsingResults.index!];
    final widget = WidgetDynamicSizeWrapper(
      defaultHeight: 50,
      key: MathConstructionKey.setKey(ExpKey()),
      connectedKeysToHeight: const [],
      connectedKeysToWidth: [expGlobalKey, baseGlobalKey],
      child: Stack(
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
              children: [
                textField,
              ],
            ),
          ),
        ],
      ),
    );
    
    return MathConstructionWidgetData(
      construction: widget, 
      additionalWidget: additionalTextField,
    );
  }
}

class ExpKey extends GroupMathConstructionKey{
  @override
  List<String> get katexExp => ['','^{', '}'];
  
  @override
  List<int> get fieldsLocation => [0, 1];
}
