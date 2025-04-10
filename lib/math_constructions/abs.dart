import 'package:flutter/material.dart';
import 'math_construction.dart';

class Abs extends DefaultMathConstruction{
  @override
  MathConstructionKey get key => AbsKey();
  
  Abs(super.builder);

  @override
  MathConstructionWidgetData createConstruction() {
    final textFieldWidget = builder.createTextField(
      replaceOldFocus: true,
      isActive: true,
    );
    final additionalField = builder.createTextField();
    final globalKey = GlobalKey();
    final absWidget = SizedBox(
      key: MathConstructionKey.setKey(AbsKey()),
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
    
    return MathConstructionWidgetData(
      construction: absWidget, 
      additionalWidget: additionalField,
    );
  }
  
}

class AbsKey extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => [r'\left|',r'\right|'];
}

class _AbsLineWidget extends StatefulWidget {
  const _AbsLineWidget({required this.globalKey});
  final GlobalKey globalKey;

  @override
  State<_AbsLineWidget> createState() => _AbsLineWidgetState();
}

class _AbsLineWidgetState extends State<_AbsLineWidget> {
  Size? size;
  
  void getSize() {
    if (widget.globalKey.currentContext == null) return;  
    final renderBox =
        widget.globalKey.currentContext!.findRenderObject()! as RenderBox;
    size = renderBox.size;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: 2,
      height: size?.height ?? 50,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPersistentFrameCallback((_) => getSize());
  }
}
