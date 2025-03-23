import 'dart:ui';
import 'package:flutter/material.dart';
import '../../services/math_constructions_building.dart';


extension Frac on MathConstructionsBuilding {
  MathConstructionData createFracWidget() {
    final upperField = textFieldService.createTextField(
        isReplaceOperation: true, isActiveTextField: true);
    final downField = textFieldService.createTextField(
        isReplaceOperation: false, performAdictionalTextField: true);
    textFieldService.markAsGrop(upperField, downField);
    final upperGlobalKey = GlobalKey();
    final downGlobalKey = GlobalKey();
    final fracWidget = SizedBox(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            key: getKey(ElementsType.fracElement),
            children: [
              SizedBox(
                child: Row(
                  key: upperGlobalKey,
                  children: [upperField],
                ),
              ),
              FracDividerWidget(
                upperGlobalKey: upperGlobalKey,
                downGlobalKey: downGlobalKey,
              ),
              SizedBox(
                child: Row(
                  key: downGlobalKey,
                  children: [downField],
                ),
              )
            ],
          ),
        ],
      ),
    );
    return MathConstructionData(construction: fracWidget);
  }
}

class FracDividerWidget extends StatefulWidget {
  const FracDividerWidget({
    super.key,
    required this.upperGlobalKey,
    required this.downGlobalKey,
  });
  final GlobalKey upperGlobalKey;
  final GlobalKey downGlobalKey;

  @override
  State<FracDividerWidget> createState() => _FracDividerWidgetState();
}

class _FracDividerWidgetState extends State<FracDividerWidget> {
  Size? size;
  void getSize(List<FrameTiming> timings) {
    final upperRenderBox =
        widget.upperGlobalKey.currentContext?.findRenderObject() as RenderBox;
    final downRenderBox =
        widget.downGlobalKey.currentContext?.findRenderObject() as RenderBox;
    if (upperRenderBox.size.width > downRenderBox.size.width) {
      size = upperRenderBox.size;
    } else {
      size = downRenderBox.size;
    }
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addTimingsCallback(getSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width ?? 50,
      child: const Divider(
        color: Colors.black,
      ),
    );
  }
}