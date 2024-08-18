// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:math_keyboard/services/text_field_handle_and_create.dart';

enum ElementsType{fracElement,sqrtElement,fieldElement,exponentiationElement,naturalLogElement,decimalLogElement,logBaseTwoElement,logElement ,absElement,limitElement, cosElement,sinElement,tanElement,cotElement,arcsinElement,arccosElement,arctanElement,arccotElement,indefiniteIntegralElement,integralElement}

class MathConstructionsBuilding{
  final TextFieldHandleAndCreateService textFieldService;
  
  MathConstructionsBuilding({required this.textFieldService}); 
  Widget createTextField({bool replaceOldFocus = false}){
    final textField = textFieldService.createTextField(isReplaceOperation: replaceOldFocus,isActiveTextField: true);
    return textField;
  }

  Widget createFracWidget(){    
    final upperField =textFieldService.createTextField(isReplaceOperation:true,isActiveTextField: true);
    final downField = textFieldService.createTextField(isReplaceOperation:false, addAdictionalFocusNode:  true);
    final upperGlobalKey = GlobalKey();
    final downGlobalKey = GlobalKey();  
    final fracWidget = SizedBox(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            key: const ValueKey(ElementsType.fracElement),
            children: [
              SizedBox(
                child: Row(
                  key: upperGlobalKey,
                  children: [
                    upperField
                  ],
                ),
              ),
              FracDividerWidget(upperGlobalKey: upperGlobalKey,downGlobalKey: downGlobalKey,),
              SizedBox(
                child: Row(
                  key: downGlobalKey,
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
    final textField = textFieldService.createTextField(isReplaceOperation: false,isActiveTextField: true,textFieldSelectedFormat: TextFieldFormat.small);
    final widget = ExpRowWidget(baseWidget: baseWidget,globalKey: globalKey,textField: textField,);
    return widget; 
  }

  Widget createCharWidget({required bool isActiveTextField}){
    final textFieldWidget = textFieldService.createTextField(isActiveTextField: isActiveTextField, isReplaceOperation: false);
    return textFieldWidget; 
  }

  Widget createSqrtWidget(){
    final globalKey = GlobalKey(); 
    final textFieldWidget = textFieldService.createTextField(isReplaceOperation: true,isActiveTextField: true);
    final sqrtWidget = SizedBox(
      child: Stack(
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
      ],),
    ); 
    return sqrtWidget; 
  }

  Widget createLogWidget(){
    final argField = textFieldService.createTextField(isReplaceOperation: false);
    final baseField = textFieldService.createTextField(isReplaceOperation: true, isActiveTextField:  true, textFieldSelectedFormat: TextFieldFormat.small); 
    final logWidget = SizedBox(
      child: Stack(
        key: const ValueKey(ElementsType.logElement),
        clipBehavior: Clip.none,
        children: [
          const SizedBox(height: 50,child: Center(child: Text('log',style: TextStyle(fontSize: 25)))),
          Positioned(
            left: 35,
            child: Row(
            children: [
              argField,
            ],
          )),
          Positioned(
            bottom: 0,
            left: 25,
            child: Row(
            children: [
              baseField,
            ],
          )),
        ],
      ),
    );
    return logWidget; 
  }

  Widget createLimitWidget(){ 
    final argField = textFieldService.createTextField(isReplaceOperation: false,addAdictionalFocusNode: true);
    final firstDownField = textFieldService.createTextField(isReplaceOperation: true,isActiveTextField:true,textFieldSelectedFormat: TextFieldFormat.small);
    final secondDownField = textFieldService.createTextField(isReplaceOperation: false,textFieldSelectedFormat: TextFieldFormat.small); 
    final limitWidget = SizedBox(
      child: Stack(
        key: const ValueKey(ElementsType.limitElement),
        clipBehavior: Clip.none,
        children: [
          const SizedBox(height: 50,child: Center(child: Text('lim',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w400),),),),
          Positioned(
            left: 55,
            child: Row(
              children: [
                argField, 
              ],
            ),
          ),
           Positioned(
            bottom: -20,
            left: 0,
            child: Row(
              children: [
                firstDownField
              ],
            ),
          ),
          const Positioned(
            bottom: -20,
            left: 20,
            child: Icon(Icons.arrow_forward_outlined)),
           Positioned(
            bottom: -20,
            left: 35,
            child: Row(
              children: [
                secondDownField
              ],
            ),
          ),
        ],
      ),
    );
    return limitWidget; 
  }


  Widget createNamedFunctionWidget(String functionName, ElementsType type){
    final textFieldWidget = textFieldService.createTextField(isReplaceOperation: true,isActiveTextField: true,addAdictionalFocusNode: true); 
    final widget = SizedBox(
      child: Row(
        key: ValueKey(type),
        children: [
          Text(functionName,style: const TextStyle(fontSize: 22),),
          const SizedBox(width: 3,),
          textFieldWidget, 
        ],
      ),
    );
    return widget; 
  }

  Widget createAbsWidget(){
    final textFieldWidget = textFieldService.createTextField(isReplaceOperation: true,isActiveTextField: true,addAdictionalFocusNode: true);
    final globalKey = GlobalKey(); 
    final absWidget = SizedBox(
      key: const ValueKey(ElementsType.absElement),
      child: Row(
        key: globalKey,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: AbsLineWidget(globalKey: globalKey,),
          ),
          textFieldWidget,
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: AbsLineWidget(globalKey: globalKey,),
          ),
        ],
      ),
    );
    return absWidget;
  }

  Widget createBracketsWidget(){
    final textFieldWidget = textFieldService.createTextField(isReplaceOperation: true,isActiveTextField: true,);
    final adictionalField = textFieldService.createTextField(isReplaceOperation: false,);
    final backetsWidget = Row(
      children: [
        BacketsWidget(textFieldWidget: textFieldWidget),
        adictionalField,
      ],
    ) ;
    return backetsWidget;  
  }

  Widget createUndefinitIntegralWidget(){
    final argFieldWidget = textFieldService.createTextField(isReplaceOperation: true,isActiveTextField: true);
    final derevativeField = textFieldService.createTextField(isReplaceOperation: false,addAdictionalFocusNode: true);
    // final addictionalField = textFieldService.createTextField(isReplaceOperation: false, );
    final integralWidget = Row(
      children: [
        Row(
          key: const ValueKey(ElementsType.indefiniteIntegralElement),
          children: [
            const Text('∫',style: TextStyle(fontSize: 30),),
            IntegralArgumentWidget(argumentWidget: argFieldWidget,),
            const Text('d',style: TextStyle(fontSize: 25),),
            derevativeField,
          ],
        )
      ],
    );
    return integralWidget;
  }

  Widget createIntegralWidget(){
    final startPointField = textFieldService.createTextField(isReplaceOperation: true,isActiveTextField: true ,addAdictionalFocusNode: false,textFieldSelectedFormat: TextFieldFormat.small);
    final finishPointField = textFieldService.createTextField(isReplaceOperation: false,addAdictionalFocusNode: false,textFieldSelectedFormat: TextFieldFormat.small);
    final argFieldWidget = textFieldService.createTextField(isReplaceOperation: false);
    final derevativeField = textFieldService.createTextField(isReplaceOperation: false,addAdictionalFocusNode: true);
    final integralWidget = SizedBox(
      width: 100,
      height: 50,
      child: Stack(
        key: const ValueKey(ElementsType.integralElement),
        clipBehavior: Clip.none,
        children: [
          const Positioned(left: 0,child: Text('∫',style: TextStyle(fontSize: 30),),),
          Positioned(bottom: 0,left: 5,child: startPointField),
          Positioned(top: 0,left: 5,child: finishPointField),
          Positioned(left: 10,child: argFieldWidget),
          const Positioned(child: Text('d',style: TextStyle(fontSize: 25),),),
          Positioned(right: 50,child: derevativeField),
        ],
      )
    );
    return integralWidget; 
  }


  Widget initialization(){
    final textField = textFieldService.createTextField(isReplaceOperation: false,isActiveTextField: true,textFieldSelectedFormat: TextFieldFormat.standart);
    return textField; 
  }
  
}

class IntegralArgumentWidget extends StatefulWidget {
   IntegralArgumentWidget({Key? key, required this.argumentWidget}) : super(key: key);
  final Widget argumentWidget;  
  Widget? child;
  @override
  State<IntegralArgumentWidget> createState() => _IntegralArgumentWidgetState();
}

class _IntegralArgumentWidgetState extends State<IntegralArgumentWidget> {

  @override
  Widget build(BuildContext context) {
    if(widget.child != null){
      return widget.child!; 
    }
    widget.child = Row(
      children: [
        SizedBox(child: widget.argumentWidget),
      ],
    );
    return widget.child!; 
  }
}

class BacketsWidget extends StatefulWidget {
  BacketsWidget({
    Key? key,
    required this.textFieldWidget,
  }) : super(key: key);
  final Widget textFieldWidget;
  Widget? child; 

  @override
  State<BacketsWidget> createState() => _BacketsWidgetState();
}

class _BacketsWidgetState extends State<BacketsWidget> {

  @override
  Widget build(BuildContext context) {
    if(widget.child == null){
      widget.child = Row(
        children: [
          widget.textFieldWidget,
        ],
      );
    }
    return Row(children: [
      const Text('('),
      widget.child!,
      const Text(')'),
    ],);
  }
}

class AbsLineWidget extends StatefulWidget {
  const AbsLineWidget({Key? key, required this.globalKey}) : super(key: key);
  final GlobalKey globalKey;

  @override
  State<AbsLineWidget> createState() => _AbsLineWidgetState();
}

class _AbsLineWidgetState extends State<AbsLineWidget> {
  Size? size; 
  getSize(){
    
    if(widget.globalKey.currentContext != null){
      final rendexBox = widget.globalKey.currentContext!.findRenderObject() as RenderBox;
      size = rendexBox.size;
    }
      
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    WidgetsBinding.instance.addPersistentFrameCallback((_)=> getSize());
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black,width: 3,height: size?.height ?? 50,);
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
    size = Size(renderBox.size.width+70,renderBox.size.height+25); 
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
                    child: widget.baseWidget); 
    Widget secondPositioned=Positioned(
                    key: widget.globalKey,
                    top: -5,
                    right: 40,
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
      // final row = widget.child as Row; 
      final sizedBox = widget.child as SizedBox;
      final stack = sizedBox.child! as Stack; 
      firstPositioned = stack.children[0];
      secondPositioned = stack.children[1]; 
    }
    final child = SizedBox(
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
    );
    widget.child = child; 
    return child; 

  }
}

class FracDividerWidget extends StatefulWidget {
  const FracDividerWidget({super.key, required this.upperGlobalKey, required this.downGlobalKey,});
  final GlobalKey upperGlobalKey;
  final GlobalKey downGlobalKey;  

  @override
  State<FracDividerWidget> createState() => _FracDividerWidgetState();
}

class _FracDividerWidgetState extends State<FracDividerWidget> {
  Size? size; 
  getSize(){
    final upperRenderBox = widget.upperGlobalKey.currentContext?.findRenderObject() as RenderBox;
    final downRenderBox = widget.downGlobalKey.currentContext?.findRenderObject() as RenderBox;
    if(upperRenderBox.size.width > downRenderBox.size.width){
      size = upperRenderBox.size; 
    }else{
      size = downRenderBox.size;
    }
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