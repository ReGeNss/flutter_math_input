import 'package:flutter/material.dart';
import '../services/text_field_handle_and_create.dart';
import 'index.dart';

class Derivative extends DefaultMathConstruction{
  Derivative(super.builder);

  @override
  MathConstructionKey get key => DerivativeKey();
  
  @override
  MathConstructionWidgetData createConstruction() {
    final upperField = builder.createTextField(
        replaceOldFocus: true, isActive: true);
    final downField = builder.createTextField(performAddictionalTextField: true);
      upperField as SizedBox;
      (upperField.child as TextFieldWidgetHandler).initTextInField =
          'y';
      downField as SizedBox;
      (downField.child as TextFieldWidgetHandler).initTextInField =
          'x';
    final upperGlobalKey = GlobalKey();
    final downGlobalKey = GlobalKey();
    builder.markAsGroup(upperField, downField);
    final derevativeWidget = _createDerivativeWidget(
      upperGlobalKey, 
      downGlobalKey, 
      upperField, 
      downField,
      builder.getKey(DerivativeKey()),
    );
    return MathConstructionWidgetData(construction: derevativeWidget);
  }
}

class DerivativeKey extends GroupMathConstructionKey {
  @override
  List<int> get fieldsLocation => [0, 2];

  @override
  List<String> get katexExp => ['\\frac{d','}{d','}'];
}

class EmptyDerevative extends DefaultMathConstruction{
  EmptyDerevative(super.builder);

  @override
  MathConstructionKey get key => DerivativeKey();
  
  @override
  MathConstructionWidgetData createConstruction() {
    final upperField = builder.createTextField(
        replaceOldFocus: true, isActive: true);
    final downField = builder.createTextField(
        replaceOldFocus: false, performAddictionalTextField: true);
    final upperGlobalKey = GlobalKey();
    final downGlobalKey = GlobalKey();
    builder.markAsGroup(upperField, downField);
    final derevativeWidget = _createDerivativeWidget(
      upperGlobalKey, 
      downGlobalKey, 
      upperField, 
      downField,
      builder.getKey(DerivativeKey()),
    );
    return MathConstructionWidgetData(construction: derevativeWidget);
  }
}

Widget _createDerivativeWidget(
  GlobalKey upperGlobalKey, 
  GlobalKey downGlobalKey, 
  Widget upperField, 
  Widget downField,
  ObjectKey objectKey,
) {
  return SizedBox(
    key: objectKey,
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
}