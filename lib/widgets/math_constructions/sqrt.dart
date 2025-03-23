import 'dart:ui';
import 'package:flutter/material.dart';
import '../../services/math_constructions_building.dart';

extension Sqrt on MathConstructionsBuilding{
  MathConstructionData createSqrtWidget() {
    final globalKey = GlobalKey();
    final textFieldWidget = textFieldService.createTextField(
        isReplaceOperation: true, isActiveTextField: true);
    final adictionalField =
        textFieldService.createTextField(isReplaceOperation: false);
    final sqrtWidget = SizedBox(
      key: getKey(ElementsType.sqrtElement),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            key: globalKey,
            top: 5,
            left: 25,
            child: Row(
              children: [
                textFieldWidget,
              ],
            ),
          ),
          IgnorePointer(
            child: _SqrtCustomPaint(
              globalKey: globalKey,
            ),
          ),
        ],
      ),
    );
    return MathConstructionData(construction: sqrtWidget, addictionalWidget: adictionalField);
  }
}

class _SqrtCustomPaint extends StatefulWidget {
  const _SqrtCustomPaint({
    required this.globalKey,
  });
  final GlobalKey globalKey;

  @override
  State<_SqrtCustomPaint> createState() => _SqrtCustomPaintState();
}

class _SqrtCustomPaintState extends State<_SqrtCustomPaint> {
  Size? size;
  _SqrtCustomPaintState();
  void getSize(List<FrameTiming> frameTiming) {
    final renderBox =
        widget.globalKey.currentContext?.findRenderObject() as RenderBox;
    if (size == null || (size != null && size != renderBox.size)) {
      size = renderBox.size;
      setState(() {});
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addTimingsCallback(getSize);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size((size?.width ?? 80) + 30, (size?.height ?? 50) + 5), painter: _SqrtPainter());
  }
}

class _SqrtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(10, size.height)
      ..lineTo(20, 0)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}