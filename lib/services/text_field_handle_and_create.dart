import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const textFieldDecoration = InputDecoration(focusedBorder: OutlineInputBorder(),border: InputBorder.none);
// за активний контроллер поля вважається останнє створене поле

class TextFieldHandleAndCreateService{
  final List<FocusNode> _focusNodes = []; 
  final List<TextEditingController> _textFieldControllers = [];
  late TextEditingController activeTextFieldController;  
  late int selectedTextFieldIndex; 


  Widget createTextField() {
    final controller = createTextFieldController();
    final focusNode = createFocusNode(); 

    final textFieldWidget = SizedBox(
        width: 60,
        height: 50,
        child: TextField(
          textAlign: TextAlign.center,
          focusNode: focusNode,
          keyboardType: TextInputType.none,
          decoration: textFieldDecoration,
          controller: controller,
          onTap: () {
            selectedTextFieldIndex = _focusNodes.indexOf(focusNode);
            activeTextFieldController = controller;
          },
        ));
    focusNode.requestFocus(); 
    activeTextFieldController = controller; 
    selectedTextFieldIndex = _focusNodes.indexOf(focusNode);
    return textFieldWidget; 
  }

  TextEditingController createTextFieldController(){
    final controller = TextEditingController(); 
    _textFieldControllers.add(controller);
    return controller; 
  }

  FocusNode createFocusNode(){
    final focusNode = FocusNode();
    _focusNodes.add(focusNode);
    return focusNode;
  }

  void clearAllData(){
    _focusNodes.clear();
    _textFieldControllers.clear();
    // TODO: видали фокусноди
  }


}