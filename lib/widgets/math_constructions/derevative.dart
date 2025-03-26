import 'package:flutter/material.dart';
import '../../services/math_constructions_building.dart';
import '../../services/text_field_handle_and_create.dart';
import './frac.dart';
import '../../math_constructions/index.dart';


extension Derevative on MathConstructionsBuilding{
  MathConstructionData createDerevativeWidget(String? upperFieldText, String? downFieldText) {
    final upperField = textFieldService.createTextField(
        isReplaceOperation: true, isActiveTextField: true);
    final downField = textFieldService.createTextField(
        isReplaceOperation: false, performAdictionalTextField: true);
    if (upperFieldText != null && downFieldText != null) {
      upperField as SizedBox;
      (upperField.child as TextFieldWidgetHandler).initTextInField =
          upperFieldText;
      downField as SizedBox;
      (downField.child as TextFieldWidgetHandler).initTextInField =
          downFieldText;
    }
    final upperGlobalKey = GlobalKey();
    final downGlobalKey = GlobalKey();
    textFieldService.markAsGrop(upperField, downField);
    final derevativeWidget = SizedBox(
      key: getKey(DerevativeConstuction()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Row(
              key: upperGlobalKey,
              children: [
                const Text('d', style: TextStyle(fontSize: 20)),
                upperField
              ],
            ),
          ),
          FracDividerWidget(upperGlobalKey: upperGlobalKey, downGlobalKey: downGlobalKey),
          SizedBox(
            child: Row(
              key: downGlobalKey,
              children: [
                const Text(
                  'd',
                  style: TextStyle(fontSize: 20),
                ),
                downField,
              ],
            ),
          ),
        ],
      ),
    );
    return MathConstructionData(construction: derevativeWidget);
  }
}