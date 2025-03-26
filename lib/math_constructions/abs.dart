import 'package:flutter/material.dart';
import 'math_construction.dart';

class Abs extends DefaultMathConstruction{
  Abs(super.builder);

  @override
  MathConstructionKey get key => AbsKey();
  
  @override
  MathConstructionWidgetData createConstruction() {
    final textFieldWidget = builder.createTextField(
      replaceOldFocus: true,
      isActive: true,
    );
    final adictionalField = builder.createTextField();
    final globalKey = GlobalKey();
    final absWidget = SizedBox(
      key: builder.getKey(AbsKey()),
      child: Row(
        key: globalKey,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: _AbsLineWidget(
              globalKey: globalKey,
            ),
          ),
          Row(
            children: [
              textFieldWidget,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: _AbsLineWidget(
              globalKey: globalKey,
            ),
          ),
        ],
      ),
    );
    return MathConstructionWidgetData(construction: absWidget, addictionalWidget: adictionalField);
  }
  
}

class AbsKey extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => ['\\left|','\\right|'];
}

class _AbsLineWidget extends StatefulWidget {
  const _AbsLineWidget({required this.globalKey});
  final GlobalKey globalKey;

  @override
  State<_AbsLineWidget> createState() => _AbsLineWidgetState();
}

class _AbsLineWidgetState extends State<_AbsLineWidget> {
  Size? size;
  getSize() {
    if (widget.globalKey.currentContext != null) {
      final rendexBox =
          widget.globalKey.currentContext!.findRenderObject() as RenderBox;
      size = rendexBox.size;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPersistentFrameCallback((_) => getSize());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: 2,
      height: size?.height ?? 50,
    );
  }
}