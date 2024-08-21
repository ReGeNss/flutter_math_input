// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:math_keyboard/services/formulas_tree_parsers_and_handler.dart';

const textFieldDecoration = InputDecoration(
    focusedBorder: OutlineInputBorder(), border: InputBorder.none);
// за активний контроллер поля вважається останнє створене поле
// extension FocusNodeHasListeners on FocusNode {
//   bool get hasListeners => hasListeners;
// }

class TextFieldHandleAndCreateService extends ChangeNotifier {
  List<FocusNode> _focusNodes = [];
  List<TextFieldControllerData> _textFieldControllers = [];
  late TextFieldControllerData activeTextFieldControllerData;
  late int selectedFieldIndex = 0;
  final parsingService = FormulasTreeParsersService();

  Widget createTextField(
      {required bool isReplaceOperation,
      TextFieldFormat? textFieldSelectedFormat,
      bool isActiveTextField = false,
      bool addAdictionalFocusNode = false}) {
    final focusNode = _createFocusNode();
    late final TextFieldFormat textFieldFormat;
    Size size;

    if (textFieldSelectedFormat != null) {
      textFieldFormat = textFieldSelectedFormat;
    } else {
      textFieldFormat = activeTextFieldControllerData.format;
    }

    final textFieldControllerData =
        _createTextFieldControllerData(textFieldFormat);
    final textFieldController = textFieldControllerData.controller;

    if (isReplaceOperation) {
      _focusNodes[selectedFieldIndex].dispose();
      _textFieldControllers[selectedFieldIndex].controller.dispose();
      _focusNodes =
          _addAndRemoveInList(selectedFieldIndex, _focusNodes, focusNode);
      _textFieldControllers = _addAndRemoveInList(
          selectedFieldIndex, _textFieldControllers, textFieldControllerData);
    } else {
      _focusNodes = _addToList(selectedFieldIndex, _focusNodes, focusNode);
      _textFieldControllers = _addToList(
          selectedFieldIndex, _textFieldControllers, textFieldControllerData);
    }

    if (addAdictionalFocusNode) {
      final adictionalFocusNode = _createFocusNode();
      final controller =
          _createTextFieldControllerData(TextFieldFormat.standart);
      final index = _focusNodes.indexOf(focusNode);
      _textFieldControllers =
          _addToList(index, _textFieldControllers, controller);
      _focusNodes = _addToList(index, _focusNodes, adictionalFocusNode);
    }

    if (isActiveTextField) {
      activeTextFieldControllerData = textFieldControllerData;
      selectedFieldIndex =
          _textFieldControllers.indexOf(activeTextFieldControllerData);
      focusNode.requestFocus();
    }

    if (textFieldFormat == TextFieldFormat.standart) {
      size = const Size(60, 50);
    } else if (textFieldFormat == TextFieldFormat.small) {
      size = const Size(40, 30);
    } else {
      size = const Size(60, 50);
    }
    final Widget textFiledWidget = SizedBox(
        height: size.height,
        child: TextFieldWidgetHandler(focusNode: focusNode, textFieldController: textFieldController, textFieldControllerData: textFieldControllerData,onTextFieldTap: onTextFieldTap,));
    return textFiledWidget;
  }

  bool selectNextFocus() {
    final currentIndex = selectedFieldIndex;
    selectedFieldIndex = currentIndex + 1;
    if (_focusNodes.length > selectedFieldIndex) {
      if (_focusNodes[selectedFieldIndex].hasListeners == true) {
        activeTextFieldControllerData =
            _textFieldControllers[selectedFieldIndex];
        _focusNodes[selectedFieldIndex].requestFocus();
      } else {
        // _focusNodes.removeAt(selectedFieldIndex);

        // проблема, що треба видаляти створені контролери, а не використовувати їх.
        return true;
      }
    } else {
      selectedFieldIndex = currentIndex;
    }
    return false;
  }

  void onTextFieldTap(FocusNode focusNode,TextFieldControllerData textFieldControllerData){
    selectedFieldIndex = _focusNodes.indexOf(focusNode);
          activeTextFieldControllerData = textFieldControllerData;
  }

  void selectBackFocus() {
    final currentIndex = selectedFieldIndex;
    selectedFieldIndex = currentIndex - 1;
    if (_focusNodes.length > selectedFieldIndex && selectedFieldIndex >= 0) {
      _focusNodes[selectedFieldIndex].requestFocus();
      activeTextFieldControllerData = _textFieldControllers[selectedFieldIndex];
    } else {
      selectedFieldIndex = currentIndex;
    }
  }

  void addCharToTextField(String char) {
    final currentText = activeTextFieldControllerData.controller.text;
    activeTextFieldControllerData.controller.text = currentText + char;
  }

  TextFieldControllerData _createTextFieldControllerData(
      TextFieldFormat format) {
    final controller = TextEditingController();
    final data =
        TextFieldControllerData(controller: controller, format: format);
    return data;
  }

  FocusNode _createFocusNode() {
    final focusNode = FocusNode();
    return focusNode;
  }

  void clearAllData() {
    _focusNodes.forEach((e) => e.dispose());
    _textFieldControllers.forEach((e) => e.controller.dispose());
    _focusNodes.clear();
    _textFieldControllers.clear();
    selectedFieldIndex = 0;
  }

  List<T> _addAndRemoveInList<T>(int addIndex, List<T> list, T replaceData) {
    final newList = <T>[];
    if (list.isEmpty && addIndex == 0) {
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

  List<T> _addToList<T>(int addIndex, List<T> list, T replaceData,) {
    final newList = <T>[];
    if (list.isEmpty && addIndex == 0) {
      return [replaceData];
    }
    for (int index = 0; list.length > index; index += 1) {
      if (index != addIndex) {
        newList.add(list[index]);
      } else {
          newList.addAll([list[index], replaceData]);
       
        
      }
    }
    return newList;
  }

  bool deleteCurrentState() {
    if (_textFieldControllers.length >= 2) {
      if (selectedFieldIndex - 1 >= 0) {
        _focusNodes.removeAt(selectedFieldIndex);
        _textFieldControllers.removeAt(selectedFieldIndex);
        selectedFieldIndex -= 1;
        activeTextFieldControllerData =
            _textFieldControllers[selectedFieldIndex];
        _focusNodes[selectedFieldIndex].requestFocus();
        return true;
      } else {
        // selectedFieldIndex += 1;
        
        _focusNodes.removeAt(selectedFieldIndex);
        _textFieldControllers.removeAt(selectedFieldIndex);
        activeTextFieldControllerData =
            _textFieldControllers[selectedFieldIndex];

        _focusNodes[selectedFieldIndex].requestFocus();
        return true;
      }
    }
    return false;
    // тут є приколи з 
  }
}

class TextFieldWidgetHandler extends StatefulWidget {
  TextFieldWidgetHandler({
    Key? key,
    required this.focusNode,
    required this.textFieldController, required this.textFieldControllerData, required this.onTextFieldTap,
  }) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController textFieldController;
  final TextFieldControllerData textFieldControllerData;
  final Function(FocusNode focusNode,TextFieldControllerData textFieldControllerData) onTextFieldTap;
  TextField? textField; 
  String? initTextInField; 

  @override
  State<TextFieldWidgetHandler> createState() => _TextFieldWidgetHandlerState();
}

class _TextFieldWidgetHandlerState extends State<TextFieldWidgetHandler> {
  @override
  Widget build(BuildContext context) {
    if(widget.textField == null){ widget.textField = TextField(
        textAlign: TextAlign.left,
        focusNode: widget.focusNode,
        style: const TextStyle(
          fontSize: 20
        ),
        keyboardType: TextInputType.none,
        decoration: textFieldDecoration,
        controller: widget.textFieldController,
        onChanged: (_){setState(() {});},
        onTap: () {
          widget.onTextFieldTap(widget.focusNode,widget.textFieldControllerData);
          // selectedFieldIndex = _focusNodes.indexOf(focusNode);
          // activeTextFieldControllerData = textFieldControllerData;
        },
      );
      if(widget.initTextInField != null){
        widget.textFieldController.text = widget.initTextInField!;
      }
    }
    final fieldWidget= IntrinsicWidth(
      child: widget.textField, 
    );
    return fieldWidget; 
  }
}

enum TextFieldFormat {
  standart,
  small,
}

class TextFieldControllerData {
  final TextEditingController controller;
  final TextFieldFormat format;

  TextFieldControllerData({required this.controller, required this.format});
}
