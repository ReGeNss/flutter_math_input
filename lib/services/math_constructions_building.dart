// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

enum ElementsType {
  fracElement,
  sqrtElement,
  fieldElement,
  exponentiationElement,
  naturalLogElement,
  decimalLogElement,
  logBaseTwoElement,
  logElement,
  absElement,
  limitElement,
  cosElement,
  sinElement,
  tanElement,
  cotElement,
  arcsinElement,
  arccosElement,
  arctanElement,
  arccotElement,
  indefiniteIntegralElement,
  integralElement,
  derevativeElement,
  backetsWidget,
}

class MathConstructionsBuilding {
  final TextFieldHandleAndCreateService textFieldService;

  MathConstructionsBuilding({required this.textFieldService});
  MathConstructionData createTextField({bool replaceOldFocus = false, bool? standartSize}) {
    late final Widget textField;  
    if(standartSize == null){
      textField = textFieldService.createTextField(
        isReplaceOperation: replaceOldFocus, 
        isActiveTextField: true,
      );
    } else { 
      textField = textFieldService.createTextField(
        isReplaceOperation: replaceOldFocus, 
        isActiveTextField: true,
        selectedTextFieldFormat: standartSize ? TextFieldFormat.standart : TextFieldFormat.small
      );
    }
    return MathConstructionData(construction: textField);
  }

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

  MathConstructionData createExpWidget(Widget baseWidget, TextFieldData baseFieldData) {
    final expGlobalKey = GlobalKey();
    final baseGlobalKey = GlobalKey();
    final addictionalTextField = textFieldService.createTextField(
      isReplaceOperation: false,
      isActiveTextField: false,
      selectedTextFieldFormat: TextFieldFormat.standart);
    final textField = textFieldService.createTextField(
      isReplaceOperation: false,
      isActiveTextField: true,
      selectedTextFieldFormat: TextFieldFormat.small);
    textFieldService.markAsGrop(baseFieldData, textField);
    // final widget = ExpRowWidget(
    //   baseWidget: baseWidget,
    //   expGlobalKey: expGlobalKey,
    //   textField: textField,
    //   baseGlobalKey: baseGlobalKey,
    // );
    final widget = WidgetDynamicSizeWrapper(
      defaultHeight: 50,
      connectedKeysToHeight: [],
      connectedKeysToWidth: [expGlobalKey, baseGlobalKey],
      wrappedWidget: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            key: baseGlobalKey,
            // connectedWidgetKeys: [expGlobalKey],
            left: 0,
            bottom: 0,
            child: Row(
              children: [
                baseWidget,
              ],
            ),
          ),
          RelayedPositioned(
            key: expGlobalKey,
            right:  10,
            offsetByHeight: RelayedPositionedType.fromBottom,
            connectedWidgetKeys: [baseGlobalKey],
            widgetToWrap: Row(
              key: getKey(ElementsType.exponentiationElement),
              children: [
                textField,
              ],
            ),
          )
        ],
      ),
    );
    return MathConstructionData(construction: widget, addictionalWidget: addictionalTextField);
  }

  Widget createCharWidget({required bool isActiveTextField}) {
    final textFieldWidget = textFieldService.createTextField(
        isActiveTextField: isActiveTextField, isReplaceOperation: false);
    return textFieldWidget;
  }

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

  MathConstructionData createLogWidget() {
    final addictionalField = textFieldService.createTextField(
        isReplaceOperation: false);
    final argField =
        textFieldService.createTextField(isReplaceOperation: false);
    final baseField = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        selectedTextFieldFormat: TextFieldFormat.small);
    textFieldService.markAsGrop(baseField, argField);
    final baseFieldKey = GlobalKey();
    final argFieldKey = GlobalKey();
    final logWidget = WidgetDynamicSizeWrapper(
      key: getKey(ElementsType.logElement),
      defaultHeight: 50,
      defaultWidth: 40,
      connectedKeysToHeight: [],
      connectedKeysToWidth: [baseFieldKey, argFieldKey],
      wrappedWidget: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            child: const SizedBox(
                height: 50,
                child:
                    Center(child: Text('log', style: TextStyle(fontSize: 25)))),
          ),
          RelayedPositioned(
            key: argFieldKey,
            connectedWidgetKeys: [baseFieldKey], 
            widgetToWrap: argField, 
            left: 40,
            offsetByWidth: RelayedPositionedType.fromLeft,
          ),
          RelayedPositioned(
            key: baseFieldKey,
            left: 30,
            top: 30,
            widgetToWrap: baseField, 
            connectedWidgetKeys: [baseFieldKey]
          )
        ],
      ),
    );
    return MathConstructionData(construction: logWidget, addictionalWidget: addictionalField);
  }

  MathConstructionData createLimitWidget() {
    final addictionalField = textFieldService.createTextField(
        isReplaceOperation: false);
    final argField = textFieldService.createTextField(
        isReplaceOperation: false);
    final firstDownField = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        selectedTextFieldFormat: TextFieldFormat.small);
    final secondDownField = textFieldService.createTextField(
        isReplaceOperation: false,
        selectedTextFieldFormat: TextFieldFormat.small);
    final argWidgetKey = GlobalKey();
    final firstDownFieldKey = GlobalKey();
    final secondDownFieldKey = GlobalKey();
    textFieldService.markAsGrop(firstDownField, argField); 
    final limitWidget = WidgetDynamicSizeWrapper(
          connectedKeysToHeight: [],
          defaultHeight: 50,
          defaultWidth: 50,
          connectedKeysToWidth: [firstDownFieldKey, secondDownFieldKey, argWidgetKey],
          key: getKey(ElementsType.limitElement),
          wrappedWidget: Stack(
            clipBehavior: Clip.none,
            children: [
              RelayedPositioned(
                left: 0,
                divideOffset: true,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey,secondDownFieldKey],
                widgetToWrap: SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      'lim',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              RelayedPositioned(
                key: argWidgetKey,
                left: 45,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey, secondDownFieldKey],
                widgetToWrap: argField,
              ),
              Positioned(
                key: firstDownFieldKey,
                bottom: -20,
                left: 0,
                child: Row(
                  children: [firstDownField],
                ),
              ),
              RelayedPositioned(
                bottom: -20, 
                left: 5,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey],
                widgetToWrap: Icon(Icons.arrow_forward_outlined)
              ),
              RelayedPositioned(
                key: secondDownFieldKey,
                offsetByWidth: RelayedPositionedType.fromLeft,
                connectedWidgetKeys: [firstDownFieldKey],
                bottom: -20,
                left: 40,
                widgetToWrap: secondDownField,
              ),
            ],
          ),
        );
    return MathConstructionData(construction: limitWidget, addictionalWidget: addictionalField);
  }

  MathConstructionData createNamedFunctionWidget(String functionName, ElementsType type) {
    final textFieldWidget = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        performAdictionalTextField: true);
    final widget = SizedBox(
      key: getKey(type),
      child: Row(
        children: [
          Text(
            functionName,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(
            width: 3,
          ),
          textFieldWidget,
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
    return MathConstructionData(construction: widget);
  }

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
            child: AbsLineWidget(
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
            child: AbsLineWidget(
              globalKey: globalKey,
            ),
          ),
        ],
      ),
    );
    return MathConstructionData(construction: absWidget, addictionalWidget: adictionalField);
  }

  MathConstructionData createBracketsWidget() {
    final textFieldWidget = textFieldService.createTextField(
      isReplaceOperation: true,
      isActiveTextField: true,
    );
    final adictionalField = textFieldService.createTextField(
      isReplaceOperation: false,
    );
    final backetsWidget = BacketsWidget(textFieldWidget: textFieldWidget);
    return MathConstructionData(construction: backetsWidget, addictionalWidget: adictionalField);
  }

  MathConstructionData createUndefinitIntegralWidget() {
    final argFieldWidget = textFieldService.createTextField(
        isReplaceOperation: true, isActiveTextField: true);
    final addictionalField = textFieldService.createTextField(
      isReplaceOperation: false,
    );
    final derevativeField = textFieldService.createTextField(
        isReplaceOperation: false, performAdictionalTextField: false);
    textFieldService.markAsGrop(argFieldWidget, derevativeField); 
    final integralWidget = Row(
      key: getKey(ElementsType.indefiniteIntegralElement),
      children: [
        const Text(
          '∫',
          style: TextStyle(fontSize: 25),
        ),
        Row(
          children: [argFieldWidget],
        ),
        const Text(
          'd',
          style: TextStyle(fontSize: 20),
        ),
        Row(
          children: [
            derevativeField,
          ],
        ),
      ],
    );
    return MathConstructionData(construction: integralWidget, addictionalWidget: addictionalField);
  }

  MathConstructionData createDerevativeWidget(String? upperFieldText, String? downFieldText) {
    final upperField = textFieldService.createTextField(
        isReplaceOperation: true, isActiveTextField: true);
    final downField = textFieldService.createTextField(
        isReplaceOperation: false, performAdictionalTextField: true);
    if (upperFieldText != null && downFieldText != null) {
      upperField as SizedBox;
      (upperField.child as TextFieldWidgetHandler).initTextInField =
          upperFieldText;
      downField as SizedBox;
      (downField.child as TextFieldWidgetHandler).initTextInField =
          downFieldText;
    }
    textFieldService.markAsGrop(upperField, downField);
    final derevativeWidget = SizedBox(
      key: getKey(ElementsType.derevativeElement),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Row(
              children: [
                const Text('d', style: TextStyle(fontSize: 20)),
                upperField
              ],
            ),
          ),
          const SizedBox(width: 25, child: Divider(color: Colors.black)),
          SizedBox(
            child: Row(
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
    return MathConstructionData(construction: derevativeWidget);
  }

  MathConstructionData createIntegralWidget() {
    final adictionalField = textFieldService.createTextField(
        isReplaceOperation: false,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.standart);
    final startPointField = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.small);
    final derevativeField = textFieldService.createTextField(
        isReplaceOperation: false,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.standart);
    final argFieldWidget = textFieldService.createTextField(
        isReplaceOperation: false,
        selectedTextFieldFormat: TextFieldFormat.standart);
    final finishPointField = textFieldService.createTextField(
        isReplaceOperation: false,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.small);
    final argumentKey = GlobalKey();
    final finishPointKey = GlobalKey();
    final derevativeKey = GlobalKey();
    textFieldService.markAsGrop(startPointField, derevativeField);
    final integralWidget = WidgetDynamicSizeWrapper(
      key: getKey(ElementsType.integralElement),
      connectedKeysToHeight: [],
      connectedKeysToWidth: [finishPointKey, argumentKey, derevativeKey],
      defaultHeight: 60,
      defaultWidth: 25,
      wrappedWidget: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            const Positioned(
              left: 0,
              child: Center(
                  child: Text(
                '∫',
                style: TextStyle(fontSize: 30),
              )),
            ),
      
            Positioned(bottom: -5, left: 5, child: Row(
              children: [
                startPointField,
              ],
            )),
            Positioned(key: finishPointKey, top: -10, left: 10, child: Row(
              children: [
                finishPointField,
              ],
            )),
            RelayedPositioned(
                key: argumentKey,
                connectedWidgetKeys: [finishPointKey],
                offsetByWidth: RelayedPositionedType.fromLeft,
                left: 10,
                widgetToWrap: ArgumentWidget(argumentWidget: argFieldWidget)),
            RelayedPositioned(
              left: 10,
              offsetByWidth: RelayedPositionedType.fromLeft,
              connectedWidgetKeys: [finishPointKey, argumentKey],
              widgetToWrap: Text(
                'd',
                style: TextStyle(fontSize: 20),
              ),
            ),
            RelayedPositioned(
              key: derevativeKey,
              left: 20,
              widgetToWrap: derevativeField,
              connectedWidgetKeys: [argumentKey, finishPointKey],
              offsetByWidth: RelayedPositionedType.fromLeft,
            ),
          ],
        ),
    );
    return MathConstructionData(construction: integralWidget, addictionalWidget: adictionalField);
  }

  Widget initialization() {
    final textField = textFieldService.createTextField(
        isReplaceOperation: false,
        isActiveTextField: true,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.standart);
    return textField;
  }
}

class RelayedPositioned extends StatefulWidget {
  RelayedPositioned({
    super.key,
    required this.widgetToWrap,
    required this.connectedWidgetKeys,
    this.offsetByHeight,
    this.offsetByWidth,
    this.right,
    this.left,
    this.top,
    this.bottom,
    this.divideOffset = false,
  });

  Widget widgetToWrap;
  final bool divideOffset; 
  final List<GlobalKey> connectedWidgetKeys;
  final double? right; 
  final double? left;
  final double? top;
  final double? bottom;
  final RelayedPositionedType? offsetByHeight;
  final RelayedPositionedType? offsetByWidth;
  Widget? wrappedWidget; 

  @override
  State<RelayedPositioned> createState() => _RelayedPositionedState();
}

class _RelayedPositionedState extends State<RelayedPositioned> {
  double? widthOffset; 
  double? heightOffset;

  void getSize(List<FrameTiming> frameTiming) {
    widthOffset = 0;
    heightOffset = 0;
    for (final key in widget.connectedWidgetKeys) {
      if (key.currentContext != null) {
        final renderBox = key.currentContext
            ?.findRenderObject() as RenderBox;
        if (widthOffset == null ||
            widthOffset != renderBox.size.width ||
            heightOffset == null ||
            heightOffset != renderBox.size.height) {
          widthOffset = (widthOffset ?? 0) + renderBox.size.width;
          heightOffset = (heightOffset ?? 0) + renderBox.size.height;
          setState(() {});
        }
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
  }

  @override
  void initState() {
    if(widget.widgetToWrap is! Row){
      widget.widgetToWrap = Row(
        children: [
          widget.widgetToWrap,
        ],
      );
    }
    WidgetsBinding.instance.addTimingsCallback(getSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? topOffset = widget.top;
    double? bottomOffset = widget.bottom;
    double? leftOffset = widget.left;
    double? rightOffset = widget.right;

    if(widget.offsetByHeight != null){
      switch(widget.offsetByHeight!) {
        case RelayedPositionedType.fromBottom:
          if(bottomOffset != null){
            bottomOffset += heightOffset ?? 0;
          }else{
            bottomOffset = heightOffset ?? 0;
          }
          if(widget.divideOffset == true){
            bottomOffset = bottomOffset / 2;
          }
          break;
        case RelayedPositionedType.fromTop:
          if(topOffset != null){
            topOffset += heightOffset ?? 0;
          }else{
            topOffset = heightOffset ?? 0;
          }
          if(widget.divideOffset == true){
            topOffset = topOffset / 2;
          }
          break;
        default:
          break;
      }
    }

    if(widget.offsetByWidth != null){
      switch(widget.offsetByWidth!) {
        case RelayedPositionedType.fromLeft:
          if(leftOffset != null){
            leftOffset += widthOffset ?? 0;
          }else{
            leftOffset = widthOffset ?? 0;
          }
          if(widget.divideOffset == true){
            leftOffset = leftOffset / 2;
          }
          break;
        case RelayedPositionedType.fromRight:
          if(rightOffset != null){
            rightOffset += widthOffset ?? 0;
          }else{
            rightOffset = widthOffset ?? 0;
          }
          if(widget.divideOffset == true){
            rightOffset = rightOffset / 2;
          }
          break;
        default:
          break;
      }
    }
    widthOffset ??= 0;
    widget.wrappedWidget = Positioned(
      top: topOffset,
      left: leftOffset,
      right: rightOffset,
      bottom: bottomOffset,
      child: widget.widgetToWrap,
    );
    return widget.wrappedWidget!;
  }
}

class ArgumentWidget extends StatefulWidget {
  ArgumentWidget({super.key, required this.argumentWidget});
  final Widget argumentWidget;
  Widget? child;
  @override
  State<ArgumentWidget> createState() => _ArgumentWidgetState();
}

class _ArgumentWidgetState extends State<ArgumentWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.child != null) {
      return widget.child!;
    }
    widget.child = Row(
      children: [
        widget.argumentWidget,
      ],
    );
    return widget.child!;
  }
}

class BacketsWidget extends StatefulWidget {
  BacketsWidget({
    required this.textFieldWidget,
  }) : super(key: getKey(ElementsType.backetsWidget));
  final Widget textFieldWidget;
  Widget? child;

  @override
  State<BacketsWidget> createState() => _BacketsWidgetState();
}

class _BacketsWidgetState extends State<BacketsWidget> {
  @override
  Widget build(BuildContext context) {
    widget.child ??= Row(
        children: [
          widget.textFieldWidget,
        ],
      );
    return Row(
      children: [
        const Text('(',style: TextStyle(fontSize: 20),),
        widget.child!,
        const Text(')',style: TextStyle(fontSize: 20),)
      ],
    );
  }
}

class AbsLineWidget extends StatefulWidget {
  const AbsLineWidget({super.key, required this.globalKey});
  final GlobalKey globalKey;

  @override
  State<AbsLineWidget> createState() => _AbsLineWidgetState();
}

class _AbsLineWidgetState extends State<AbsLineWidget> {
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

ObjectKey getKey(ElementsType type){
  return ObjectKey(MathConstructionKey(type: type));
}

class MathConstructionKey{
  final ElementsType type;
  
  MathConstructionKey({required this.type,});
}

class WidgetDynamicSizeWrapper extends StatefulWidget {
  WidgetDynamicSizeWrapper({
    super.key,
    required this.connectedKeysToWidth,
    required this.wrappedWidget, 
    required this.connectedKeysToHeight,
    this.defaultWidth, 
    this.defaultHeight,
  });

  final List<GlobalKey> connectedKeysToWidth;
  final List<GlobalKey> connectedKeysToHeight;
  final double? defaultWidth;
  final double? defaultHeight; 
  Widget wrappedWidget; 

  @override
  State<WidgetDynamicSizeWrapper> createState() => _WidgetDynamicSizeWrapperState();
}

class _WidgetDynamicSizeWrapperState extends State<WidgetDynamicSizeWrapper> {
  double width = 0; 
  double height = 0;

  void getSize(List<FrameTiming> timings) {
    height = 0; 
    width = 0;
    for(final key in widget.connectedKeysToWidth) { 
      if(key.currentContext != null){
        final renderBox = key.currentContext?.findRenderObject() as RenderBox;
        if(width != renderBox.size.width || height != renderBox.size.height){
          width += renderBox.size.width;
          if(height < renderBox.size.height){
            height = renderBox.size.height;
          }
        }
      }
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
      height: widget.defaultHeight,
      width: width + (widget.defaultWidth ?? 0),
      child: widget.wrappedWidget,
    );
  }
}

class MathConstructionData {
  final Widget? addictionalWidget;
  final Widget construction;

  MathConstructionData({required this.construction, this.addictionalWidget});
}

enum RelayedPositionedType {
  fromRight,
  fromLeft,
  fromTop,
  fromBottom,
}