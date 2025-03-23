import 'package:flutter/material.dart';
import '../../services/math_constructions_building.dart';

extension Abs on MathConstructionsBuilding{
  MathConstructionData createAbsWidget() {
    final textFieldWidget = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        performAdictionalTextField: false);
    final adictionalField =
        textFieldService.createTextField(isReplaceOperation: false);

    final globalKey = GlobalKey();
    final absWidget = SizedBox(
      key: getKey(ElementsType.absElement),
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
    return MathConstructionData(construction: absWidget, addictionalWidget: adictionalField);
  }
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