import 'dart:ui';
import 'package:flutter/material.dart';
import '../interfaces/index.dart';
import '../interfaces/math_construction.dart';

class Sqrt extends DefaultMathConstruction{
  @override
  MathConstructionKey get key => SqrtKey();
  
  Sqrt(super.builder);

  @override
  MathConstructionWidgetData createConstruction() {
    final globalKey = GlobalKey();
    final textFieldWidget = builder.createTextField(
      replaceOldFocus: true, isActive: true,
    );
    final additionalField = builder.createTextField();
    final sqrtWidget = SizedBox(
      key: MathConstructionKey.setKey(SqrtKey()),
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

    return MathConstructionWidgetData(
      construction: sqrtWidget, 
      additionalWidget: additionalField,
    );
  }
}

class SqrtKey extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => [r'\sqrt{', '}'];
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

  // ignore: proper_super_calls
  @override
  void initState() {
    WidgetsBinding.instance.addTimingsCallback(getSize);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size((size?.width ?? 80) + 30, (size?.height ?? 50) + 5),
      painter: _SqrtPainter(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
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
