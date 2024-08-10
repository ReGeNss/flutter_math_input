import 'package:flutter/material.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

enum ElementsType{fracElement,sqrtElement,fieldElement,exponentiationElement}

class MathConstructionsBuilding{
  final TextFieldHandleAndCreateService textFiledService;
  
  MathConstructionsBuilding({required this.textFiledService}); 
  Widget createTextField(){
    final textField = textFiledService.createTextField(amountOfField:  1,isReplaceOperation: true);
    return textField.first;
  }

  Widget createFracWidget(){    
    final textFiledWidgets = textFiledService.createTextField(amountOfField:2,isReplaceOperation:true, addAdictionalFocusNode:  true);
    final globalKey = GlobalKey(); 
    final fracWidget = Column(
      key: const ValueKey(ElementsType.fracElement),
      children: [
        SizedBox(
          child: Row(
            key: globalKey,
            children: [
              textFiledWidgets[0]
            ],
          ),
        ),
        FracDividerWidget(globalKey: globalKey,),
        SizedBox(
          child: Row(
            children: [
             textFiledWidgets[1]
            ],
          ),
        )
      ],
    );
    return fracWidget; 
  }
  List<Widget> createCharWidget({required int amountOfField}){
    final textFieldWidget = textFiledService.createTextField(amountOfField: amountOfField, isReplaceOperation: false);
    return textFieldWidget; 
  }



  Widget initialization(){
    final textField = textFiledService.createTextField(amountOfField:  1,isReplaceOperation:  true);
    return textField.first; 
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