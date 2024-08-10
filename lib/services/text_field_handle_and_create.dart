import 'package:flutter/material.dart';
import 'package:math_keyboard/services/formulas_tree_parsers_and_handler.dart';

const textFieldDecoration = InputDecoration(focusedBorder: OutlineInputBorder(),border: InputBorder.none);
// за активний контроллер поля вважається останнє створене поле
// extension FocusNodeHasListeners on FocusNode {
//   bool get hasListeners => hasListeners;
// }

class TextFieldHandleAndCreateService extends ChangeNotifier{
  List<FocusNode> _focusNodes = []; 
  List<TextEditingController> _textFieldControllers = [];
  late TextEditingController activeTextFieldController;  
  late int selectedFieldIndex=0; 
  final parsingService = FormulasTreeParsersService(); 


  List<Widget> createTextField({ required int amountOfField, required isReplaceOperation,addAdictionalFocusNode = false}) {
    final List<Widget> textFields=[]; 
    final List<TextEditingController> controllersList=[];
    final List<FocusNode> focusNodes =[]; 
    for(int index= 0; amountOfField>index; index+=1){
      focusNodes.add(_createFocusNode());
      controllersList.add(_createTextFieldController());
    }
    if(isReplaceOperation && _focusNodes.isNotEmpty ){
      _focusNodes[selectedFieldIndex].dispose();
      _textFieldControllers[selectedFieldIndex].dispose(); 
      _focusNodes =_addAndRemoveInList(selectedFieldIndex,_focusNodes, focusNodes); 
      _textFieldControllers =_addAndRemoveInList(selectedFieldIndex,_textFieldControllers, controllersList); 
    }else if(_focusNodes.isNotEmpty){
      _focusNodes= _addToList(selectedFieldIndex, _focusNodes, focusNodes);
      _textFieldControllers = _addToList(selectedFieldIndex, _textFieldControllers, controllersList); 
    }else{
      _focusNodes = focusNodes.toList();
      _textFieldControllers = controllersList.toList(); 
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
    // if(isReplaceOperation){
    //   _createFocusNode(); 
    // }
    if(addAdictionalFocusNode){
      _focusNodes = _addToList(selectedFieldIndex+1,_focusNodes,[FocusNode()]);
      _textFieldControllers = _addToList(selectedFieldIndex+1, _textFieldControllers, [TextEditingController()]); 
      // _textFieldControllers.add(TextEditingController()); 
    }
    focusNodes[0].requestFocus(); 
    activeTextFieldController = controllersList[0]; 
    selectedFieldIndex = _focusNodes.indexOf(focusNodes[0]);
    return  textFields; 
  }

  bool selectNextFocus(){
    final currentIndex = selectedFieldIndex;
    selectedFieldIndex = currentIndex + 1;
    if( _focusNodes.length > selectedFieldIndex){
      if(_focusNodes[selectedFieldIndex].hasListeners == true){
        activeTextFieldController = _textFieldControllers[selectedFieldIndex]; 
        _focusNodes[selectedFieldIndex].requestFocus(); 
      }
      else{
        // _focusNodes.removeLast(); 
        // проблема, що треба видаляти створені контролери, а не використовувати їх. 
        return true; 
      }
    }
    else{
      selectedFieldIndex = currentIndex; 
    }
    return false; 
  }


  void selectBackFocus() {
    final currentIndex = selectedFieldIndex;
    selectedFieldIndex = currentIndex - 1;
    if (_focusNodes.length > selectedFieldIndex && selectedFieldIndex >= 0) {
      _focusNodes[selectedFieldIndex].requestFocus();
      activeTextFieldController = _textFieldControllers[selectedFieldIndex];
    } else {
      selectedFieldIndex = currentIndex;
    }
  }







  TextEditingController _createTextFieldController(){
    final controller = TextEditingController(); 
    return controller; 
  }

  
  FocusNode _createFocusNode(){
    final focusNode = FocusNode();
    return focusNode;
  }


  void clearAllData(){
    _focusNodes.forEach((e) =>e.dispose());
    _textFieldControllers.forEach((e) => e.dispose());
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
  List<T> _addToList<T>(int addIndex, List<T> list, List<T> replaceData){
    final newList = <T>[];
    for(int index= 0; list.length > index; index+=1){
      if(index != addIndex){
        newList.add(list[index]);
      }else{
        newList.add(list[index]);
        newList.addAll(replaceData); 
      }
    }
    return newList; 
  }


}