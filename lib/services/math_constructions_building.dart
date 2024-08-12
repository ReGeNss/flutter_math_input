import 'package:flutter/material.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

enum ElementsType{fracElement,sqrtElement,fieldElement,exponentiationElement}

class MathConstructionsBuilding{
  final TextFieldHandleAndCreateService textFiledService;
  
  MathConstructionsBuilding({required this.textFiledService}); 
  Widget createTextField({bool replaceOldFocus = false}){
    final textField = textFiledService.createTextField(isReplaceOperation: replaceOldFocus,isActiveTextField: true);
    return textField;
  }

  Widget createFracWidget(){    
    final upperField =textFiledService.createTextField(isReplaceOperation:true,isActiveTextField: true);
    final downField = textFiledService.createTextField(isReplaceOperation:false, addAdictionalFocusNode:  true);
    final globalKey = GlobalKey(); 
    final fracWidget = SizedBox(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            key: const ValueKey(ElementsType.fracElement),
            children: [
              SizedBox(
                child: Row(
                  key: globalKey,
                  children: [
                    upperField
                  ],
                ),
              ),
              FracDividerWidget(globalKey: globalKey,),
              SizedBox(
                child: Row(
                  children: [
                   downField
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
    return fracWidget; 
  }

  Widget createExpWidget(Widget baseWidget){
    final globalKey = GlobalKey(); 
    final textField = textFiledService.createTextField(isReplaceOperation: false,isActiveTextField: true,textFieldSelectedFormat: TextFieldFormat.small);
    final widget = ExpRowWidget(baseWidget: baseWidget,globalKey: globalKey,textField: textField,);
    return widget; 
  }

  Widget createCharWidget({required bool isActiveTextField}){
    final textFieldWidget = textFiledService.createTextField(isActiveTextField: isActiveTextField, isReplaceOperation: false);
    return textFieldWidget; 
  }

  Widget createSqrtWidget(){
    final globalKey = GlobalKey(); 
    final textFieldWidget = textFiledService.createTextField(isReplaceOperation: true,isActiveTextField: true);
    final sqrtWidget = Stack(
      clipBehavior: Clip.none,
      children: [
      Positioned(
        key: globalKey,
        top: 5,
        left: 25,
        child: Row(
          key: const ValueKey(ElementsType.sqrtElement),
          children: [
            textFieldWidget,
          ],
        ),
      ),
      IgnorePointer(
        child: _SqrtCustomPaint(globalKey: globalKey,),
      ),
    ],); 
    return sqrtWidget; 
  }

  Widget createNamedFunctionWidget(String functionName){
    final textFieldWidget = textFiledService.createTextField(isReplaceOperation: true,isActiveTextField: true,addAdictionalFocusNode: true); 
    final widget = SizedBox(
      child: Row(
        children: [
          Text(functionName,style: const TextStyle(fontSize: 22),),
          const SizedBox(width: 3,),
          textFieldWidget, 
        ],
      ),
    );
    return widget; 
  }




  Widget initialization(){
    final textField = textFiledService.createTextField(isReplaceOperation: false,isActiveTextField: true,textFieldSelectedFormat: TextFieldFormat.standart);
    return textField; 
  }
  
}

class _SqrtCustomPaint extends StatefulWidget {
  const _SqrtCustomPaint({
    super.key, required this.globalKey,
  });
  final GlobalKey globalKey;

  @override
  State<_SqrtCustomPaint> createState() => _SqrtCustomPaintState();
}

class _SqrtCustomPaintState extends State<_SqrtCustomPaint> {
  Size? size;  
  _SqrtCustomPaintState(); 
  void getSize(){
    final renderBox =widget.globalKey.currentContext?.findRenderObject() as RenderBox; 
    size = renderBox.size;  
    setState(() {
      
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) =>getSize());
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size((size?.width ?? 80) +30,50 ),
      painter:  _SqrtPainter());
  }
}

class _SqrtPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(0,size.height / 2)
      ..lineTo(10, size.height)
      ..lineTo(20,0)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, paint);

  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; 
  }

}

// ignore: must_be_immutable
class ExpRowWidget extends StatefulWidget {
  ExpRowWidget({Key? key, required this.baseWidget, required this.globalKey, this.child, required this.textField}) : super(key: key);
  final Widget baseWidget; 
  final GlobalKey globalKey; 
  Widget? child; 
  final Widget textField; 

  @override
  State<ExpRowWidget> createState() => _ExpRowWidgetState();
}

class _ExpRowWidgetState extends State<ExpRowWidget> {
  Size size = const Size(120, 60); 
  void getSize(){
    final renderBox = widget.globalKey.currentContext?.findRenderObject() as RenderBox; 
    size = Size(renderBox.size.width+70,renderBox.size.height+20); 
    setState(() {});
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_)=> getSize());
  }

  @override
  Widget build(BuildContext context) {
    Widget firstPositioned=Positioned(
                    left: 0,
                    bottom: 0,
                    child: Row(
                      children: [
                        widget.baseWidget,
                      ],
                    )); 
    Widget secondPositioned=Positioned(
                    key: widget.globalKey,
                    top: -5,
                    left: 45,
                    child: Row(
                      key: const ValueKey(ElementsType.exponentiationElement),
                      children: [
                        SizedBox(
                          height: 30,
                          width: 40,
                          child: widget.textField
                        ),
                      ],
                    ));
    if(widget.child != null){
      final row = widget.child as Row; 
      final sizedBox = row.children[0] as SizedBox;
      final stack = sizedBox.child! as Stack; 
      firstPositioned = stack.children[0];
      secondPositioned = stack.children[1]; 
    }
    final child = Row(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topRight,
            children: [
              firstPositioned,
              secondPositioned, 
            ],
          ),
        )
      ],
    );
    widget.child = child; 
    return child; 

  }
}

class FracDividerWidget extends StatefulWidget {
  const FracDividerWidget({Key? key, required this.globalKey}) : super(key: key);
  final GlobalKey globalKey; 

  @override
  State<FracDividerWidget> createState() => _FracDividerWidgetState();
}

class _FracDividerWidgetState extends State<FracDividerWidget> {
  Size? size; 
  getSize(){
    final renderBox = widget.globalKey.currentContext?.findRenderObject() as RenderBox;
    size = renderBox.size; 
    setState(() {
      
    });   
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_)=> getSize()); 
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size?.width ?? 50 ,child: const Divider(color: Colors.black,),);
  }
}