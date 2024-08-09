import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const textFieldDecoration = InputDecoration(focusedBorder: OutlineInputBorder(),border: InputBorder.none);
// за активний контроллер поля вважається останнє створене поле

class TextFieldHandleAndCreateService{
  final List<FocusNode> _focusNodes = []; 
  final List<TextEditingController> _textFieldControllers = [];
  late TextEditingController activeTextFieldController;  
  late int selectedFieldIndex=0; 


  List<Widget> createTextField(int amountOfField,bool isReplaceOperation) {
    final List<Widget> textFields=[]; 
    final List<TextEditingController> controllersList=[];
    final List<FocusNode> focusNodes =[]; 
    for(int index= 0; amountOfField>index; index+=1){
      focusNodes.add(_createFocusNode());
      controllersList.add(_createTextFieldController());
    }
    if(isReplaceOperation){
      _addAndRemoveInList(selectedFieldIndex,_focusNodes, focusNodes); 
      _addAndRemoveInList(selectedFieldIndex,_textFieldControllers, controllersList); 
    }else{
      _addToList(selectedFieldIndex, _focusNodes, focusNodes);
      _addAndRemoveInList(selectedFieldIndex, _textFieldControllers, controllersList); 
    }

    for(int index= 0; amountOfField>index; index+=1){
      final textFieldWidget = SizedBox(
        width: 60,
        height: 50,
        child: TextField(
          textAlign: TextAlign.center,
          focusNode: focusNodes[index],
          keyboardType: TextInputType.none,
          decoration: textFieldDecoration,
          controller: controllersList[index],
          onTap: () {
            selectedFieldIndex = _focusNodes.indexOf(focusNodes[index]);
            activeTextFieldController = controllersList[index];
          },
        ));
      textFields.add(textFieldWidget); 
    }
    if(isReplaceOperation){
      _createFocusNode(); 
    }

    focusNodes[0].requestFocus(); 
    activeTextFieldController = controllersList[0]; 
    selectedFieldIndex = _focusNodes.indexOf(focusNodes[0]);
    return  textFields; 
  }

  







  TextEditingController _createTextFieldController(){
    final controller = TextEditingController(); 
    // controller.text = '123'; 
    _textFieldControllers.add(controller);
    return controller; 
  }

  
  FocusNode _createFocusNode(){
    final focusNode = FocusNode();
    _focusNodes.add(focusNode);
    return focusNode;
  }


  void clearAllData(){
    _focusNodes.clear();
    _textFieldControllers.clear();
    // TODO: видали фокусноди
  }

  List<T> _addAndRemoveInList<T>(
      int addIndex, List<T> list, List<T> replaceData) {
    final newList = <T>[];
    for (int index = 0; list.length > index; index += 1) {
      if (index != addIndex) {
        newList.add(list[index]);
      } else {
        newList.addAll(replaceData);
      }
    }
    return newList;
  }
  List<T> _addToList<T>(int addIndex, List<T> list, T replaceData){
    final newList = <T>[];
    for(int index= 0; list.length > index; index+=1){
      if(index != addIndex){
        newList.add(list[index]);
      }else{
        newList.addAll([list[index] ,replaceData]);
      }
    }
    return newList; 
  }


}