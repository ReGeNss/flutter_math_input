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
  Widget createCharWidget({required bool isActiveTextField}){
    final textFieldWidget = textFiledService.createTextField(isActiveTextField: isActiveTextField, isReplaceOperation: false);
    return textFieldWidget; 
  }



  Widget initialization(){
    final textField = textFiledService.createTextField(isReplaceOperation: false,isActiveTextField: true);
    return textField; 
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