import 'dart:ui';
import 'package:flutter/material.dart';
import '../interfaces/index.dart';

class Frac extends DefaultMathConstruction{
  @override
  MathConstructionKey get key => FracKey();

  Frac(super.builder);

  @override
  MathConstructionWidgetData createConstruction() {
    final upperField = builder.createTextField(
        replaceOldFocus: true, isActive: true,);
    final downField = builder.createTextField(performAdditionalTextField: true);
    builder.markAsGroup(upperField, downField);
    final upperGlobalKey = GlobalKey();
    final downGlobalKey = GlobalKey();
    final fracWidget = SizedBox(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            key: MathConstructionKey.setKey(FracKey()),
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
              ),
            ],
          ),
        ],
      ),
    );

    return MathConstructionWidgetData(construction: fracWidget);
  }
}

class FracKey extends GroupMathConstructionKey{
  @override
  List<int> get fieldsLocation => [0, 2];
  
  @override
  List<String> get katexExp => [r'\frac{', '}{', '}'];
}

class FracDividerWidget extends StatefulWidget {
  const FracDividerWidget({
    required this.upperGlobalKey,
    required this.downGlobalKey,
    super.key,
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
    size = upperRenderBox.size.width > downRenderBox.size.width 
      ? upperRenderBox.size 
      : downRenderBox.size;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addTimingsCallback(getSize);
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

  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
  }
}
