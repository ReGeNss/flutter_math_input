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


  Widget createTextField({required bool isReplaceOperation, bool isActiveTextField = false, bool addAdictionalFocusNode = false}){
    final focusNode = _createFocusNode(); 
    final textFieldController = _createTextFieldController();
    if(isReplaceOperation){
      _focusNodes[selectedFieldIndex].dispose();
      _textFieldControllers[selectedFieldIndex].dispose(); 
      _focusNodes = _addAndRemoveInList(selectedFieldIndex, _focusNodes, focusNode);
      _textFieldControllers = _addAndRemoveInList(selectedFieldIndex, _textFieldControllers, textFieldController);
    }else{
      _focusNodes = _addToList(selectedFieldIndex, _focusNodes, focusNode);
      _textFieldControllers = _addToList(selectedFieldIndex, _textFieldControllers, textFieldController);
    }
    if(addAdictionalFocusNode){
      final focusNode = _createFocusNode(); 
      final controller = _createTextFieldController();
      _textFieldControllers = _addToList(selectedFieldIndex+1, _textFieldControllers, controller);
      _focusNodes = _addToList(selectedFieldIndex+1, _focusNodes, focusNode);
    }
    if(isActiveTextField){
      activeTextFieldController = textFieldController;
      selectedFieldIndex = _textFieldControllers.indexOf(activeTextFieldController);
      focusNode.requestFocus();   
    }
    final Widget textFiledWidget = SizedBox(
        width: 60,
        height: 50,
        child: TextField(
          textAlign: TextAlign.center,
          focusNode: focusNode,
          keyboardType: TextInputType.none,
          decoration: textFieldDecoration,
          controller: textFieldController,
          onTap: () {
            selectedFieldIndex = _focusNodes.indexOf(focusNode);
            activeTextFieldController = textFieldController;
          },
        ));
    return textFiledWidget; 

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
        // _focusNodes.removeAt(selectedFieldIndex); 
        
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
    print('dadaddada$selectedFieldIndex'); 
    _focusNodes.forEach((e) =>e.dispose());
    _textFieldControllers.forEach((e) => e.dispose());
    _focusNodes.clear();
    _textFieldControllers.clear();
    selectedFieldIndex = 0; 
    // TODO: видали фокусноди
  }

  List<T> _addAndRemoveInList<T>(
      int addIndex, List<T> list, T replaceData) {
    final newList = <T>[];
     if(list.length ==0 && addIndex == 0){
      return [replaceData]; 
    }
    for (int index = 0; list.length > index; index += 1) {
      if (index != addIndex) {
        newList.add(list[index]);
      } else {
        newList.add(replaceData);
      }
    }
    return newList;
  }
  List<T> _addToList<T>(int addIndex, List<T> list, T replaceData){
    final newList = <T>[];
    if(list.length ==0 && addIndex == 0){
      return [replaceData]; 
    }
    for(int index= 0; list.length > index; index+=1){
      if(index != addIndex){
        newList.add(list[index]);
      }else{
        newList.addAll([list[index],replaceData]);
      }
    }
    return newList; 
  }


}