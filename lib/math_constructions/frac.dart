import 'dart:ui';
import 'package:flutter/material.dart';
import 'math_construction.dart';

class Frac extends DefaultMathConstruction{
  Frac(super.builder);

  @override
  MathConstructionWidgetData createConstruction() {
    final upperField = builder.createTextField(
        replaceOldFocus: true, isActive: true);
    final downField = builder.createTextField(performAddictionalTextField: true);
    builder.markAsGroup(upperField, downField);
    final upperGlobalKey = GlobalKey();
    final downGlobalKey = GlobalKey();
    final fracWidget = SizedBox(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            key: builder.getKey(FracKey()),
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
    return MathConstructionWidgetData(construction: fracWidget);
  }

  @override
  MathConstructionKey get key => FracKey();
}

class FracKey extends GroupMathConstructionKey{
  @override
  List<int> get fieldsLocation => [0, 2];
  
  @override
  List<String> get katexExp => ['\\frac{', '}{', '}'];
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