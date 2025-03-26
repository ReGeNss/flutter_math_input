import 'package:flutter/material.dart';
import '../services/text_field_handle_and_create.dart';
import '../widgets/supportive_widges/relayed_positioned.dart';
import '../widgets/supportive_widges/widget_dynamic_size_wrapper.dart';
import 'math_construction.dart';

class Exp extends ComplicatedMathConstruction{
  Exp(super.builder, {required super.textFieldService, required super.parsingResults, required super.widgetTree});

  @override
  MathConstructionKey get key => ExpKey();
  
  @override
  MathConstructionWidgetData createConstruction() {
    final activeTextFieldController = textFieldService.getActiveTextFieldController();
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
    final addictionalTextField = builder.createTextField(
      format: TextFieldFormat.standart
    );
    final textField = builder.createTextField(
      isActive: true,
      format: TextFieldFormat.small
    );
    textFieldService.markAsGrop(baseField, textField);
    final baseWidget = parsingResults.wigetData![parsingResults.index!];
    final widget = WidgetDynamicSizeWrapper(
      defaultHeight: 50,
      key: builder.getKey(ExpKey()),
      connectedKeysToHeight: [],
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
              // key: getKey(ExpConstuction()),
              children: [
                textField,
              ],
            ),
          )
        ],
      ),
    );
    
    return MathConstructionWidgetData(construction: widget, addictionalWidget: addictionalTextField);
  }
}

class ExpKey extends GroupMathConstructionKey{
  @override
  List<String> get katexExp => ['','^{', '}'];
  
  @override
  List<int> get fieldsLocation => [0, 1];
}