import 'package:flutter/material.dart';
import '../interfaces/index.dart';
import '../widgets/supportive_widgets/index.dart';
import 'index.dart';

class Derivative extends DefaultMathConstruction{
  @override
  MathConstructionKey get key => DerivativeKey();
  
  Derivative(super.builder);

  @override
  MathConstructionWidgetData createConstruction() {
    final upperField = builder.createTextField(
        replaceOldFocus: true, isActive: true,);
    final downField = builder.createTextField(performAdditionalTextField: true);
      upperField as SizedBox;
      (upperField.child! as TextFieldWrapper).initTextInField =
          'y';
      downField as SizedBox;
      (downField.child! as TextFieldWrapper).initTextInField =
          'x';
    final upperGlobalKey = GlobalKey();
    final downGlobalKey = GlobalKey();
    builder.markAsGroup(upperField, downField);
    final derivativeWidget = _createDerivativeWidget(
      upperGlobalKey, 
      downGlobalKey, 
      upperField, 
      downField,
      MathConstructionKey.setKey(DerivativeKey()),
    );

    return MathConstructionWidgetData(construction: derivativeWidget);
  }
}

class DerivativeKey extends GroupMathConstructionKey {
  @override
  List<int> get fieldsLocation => [0, 2];

  @override
  List<String> get katexExp => [r'\frac{d','}{d','}'];
}

class EmptyDerivative extends DefaultMathConstruction{
  @override
  MathConstructionKey get key => DerivativeKey();

  EmptyDerivative(super.builder);

  @override
  MathConstructionWidgetData createConstruction() {
    final upperField = builder.createTextField(
        replaceOldFocus: true, isActive: true,);
    final downField = builder.createTextField(
      performAdditionalTextField: true,
    );
    final upperGlobalKey = GlobalKey();
    final downGlobalKey = GlobalKey();
    builder.markAsGroup(upperField, downField);
    final derivativeWidget = _createDerivativeWidget(
      upperGlobalKey, 
      downGlobalKey, 
      upperField, 
      downField,
      MathConstructionKey.setKey(DerivativeKey()),
    );

    return MathConstructionWidgetData(construction: derivativeWidget);
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
              upperField,
            ],
          ),
        ),
        FracDividerWidget(
          upperGlobalKey: upperGlobalKey, 
          downGlobalKey: downGlobalKey,
        ),
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
