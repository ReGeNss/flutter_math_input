// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

const textFieldDecoration = InputDecoration(
    focusedBorder: OutlineInputBorder(),
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(5));
// за активний контроллер поля вважається останнє створене поле
const minTextFieldCountToStapBack = 2;

class TextFieldHandleAndCreateService extends ChangeNotifier {
  final List<TextFieldData> _textFieildsData = [];
  final List<TextFieldGroop> _textFieldGroops = [];
  late TextFieldData activeTextFieldData;
  late int selectedFieldIndex = 0;

  Widget createTextField(
      {required bool isReplaceOperation,
      TextFieldFormat? selectedTextFieldFormat,
      bool isActiveTextField = false,
      bool performAdictionalTextField = false}) {
    late final TextFieldFormat textFieldFormat;

    if (selectedTextFieldFormat != null) {
      textFieldFormat = selectedTextFieldFormat;
    } else {
      textFieldFormat = activeTextFieldData.format;
    }
    final textFieldData = _createTextFieldData(textFieldFormat);

    if (isReplaceOperation) {
      _replaceActiveTextFieldByThis(textFieldData);
    } else {
      _insertToList(_textFieildsData, textFieldData, selectedFieldIndex);
    }

    if (performAdictionalTextField) {
      _addFocusNodeAfterThis(textFieldData);
    }

    if (isActiveTextField) {
      _makeThisTextFieldActive(textFieldData);
    }

    final size = _selectTextFieldFormat(textFieldFormat);

    final Widget textFiledWidget = SizedBox(
        height: size.height,
        child: TextFieldWidgetHandler(
          key: UniqueKey(),
          textFieldData: textFieldData,
          onTextFieldTap: onTextFieldTap,
        ));
    return textFiledWidget;
  }

  void _insertToList<T>(List<T> list, T element, int index) {
    if (list.isNotEmpty) {
      list.insert(index + 1, element);
    } else {
      list.add(element);
    }
  }

  void _replaceActiveTextFieldByThis(TextFieldData textFieldData) {
    _textFieildsData[selectedFieldIndex].focusNode.dispose();
    _textFieildsData[selectedFieldIndex].controller.dispose();

    checkGroops(textFieldData);

    _textFieildsData.replaceRange(
        selectedFieldIndex, selectedFieldIndex + 1, [textFieldData]);
  }

  Size _selectTextFieldFormat(TextFieldFormat format) {
    final Size size;
    if (format == TextFieldFormat.standart) {
      size = const Size(60, 50);
    } else if (format == TextFieldFormat.small) {
      size = const Size(40, 30);
    } else {
      size = const Size(60, 50);
    }
    return size;
  }

  void markAsGrop(dynamic startFieldData, Widget endFieldBox) {
    late final int startIndex;
    if (startFieldData is SizedBox) {
      final startField = startFieldData.child as TextFieldWidgetHandler;
      startIndex = _textFieildsData.indexOf(startField.textFieldData);
    } else if (startFieldData is TextFieldData) {
      startIndex = _textFieildsData.indexOf(startFieldData);
    }
    final endField = (endFieldBox as SizedBox).child as TextFieldWidgetHandler;
    final endIndex = _textFieildsData.indexOf(endField.textFieldData);
    _textFieldGroops.add(TextFieldGroop(
        startField: _textFieildsData[startIndex],
        endField: _textFieildsData[endIndex]));
  }

  void _addFocusNodeAfterThis(TextFieldData textFieldData) {
    final addictionalTextFieldData =
        _createTextFieldData(TextFieldFormat.standart);
    final index = _textFieildsData.indexOf(textFieldData);
    _textFieildsData.insert(index + 1, addictionalTextFieldData);
  }

  void _makeThisTextFieldActive(TextFieldData textFieldData) {
    activeTextFieldData = textFieldData;
    selectedFieldIndex = _textFieildsData.indexOf(activeTextFieldData);
    print('selectedFieldIndex: $selectedFieldIndex');
    Future.delayed(const Duration(milliseconds: 20),
        () => textFieldData.focusNode.requestFocus());
  }

  bool trySelectNextFocus() {
    final cursorPosition = activeTextFieldData.controller.selection.baseOffset;
    final textLeght = activeTextFieldData.controller.text.length;
    if (cursorPosition == textLeght) {
      final previousIndex = selectedFieldIndex;
      selectedFieldIndex = previousIndex + 1;
      if (_textFieildsData.length > selectedFieldIndex) {
        final focusNode = _textFieildsData[selectedFieldIndex].focusNode;
        if (focusNode.hasListeners == true) {
          activeTextFieldData = _textFieildsData[selectedFieldIndex];
          focusNode.requestFocus();
        } else {
          return false;
        }
      } else {
        selectedFieldIndex = previousIndex;
      }
    } else {
      activeTextFieldData.controller.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPosition + 1));
    }
    return true;
  }

  void onTextFieldTap(TextFieldData textFieldData) {
    selectedFieldIndex = _textFieildsData.indexOf(textFieldData);
    activeTextFieldData = textFieldData;
  }

  void selectBackFocus() {
    final cursorPosition = activeTextFieldData.controller.selection.baseOffset;
    if (cursorPosition == 0) {
      final previousIndex = selectedFieldIndex;
      selectedFieldIndex = previousIndex - 1;
      if (_textFieildsData.length > selectedFieldIndex &&
          selectedFieldIndex >= 0) {
        _textFieildsData[selectedFieldIndex].focusNode.requestFocus();
        activeTextFieldData = _textFieildsData[selectedFieldIndex];
      } else {
        selectedFieldIndex = previousIndex;
      }
    } else {
      activeTextFieldData.controller.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPosition - 1));
    }
  }

  void addCharToTextField(String char) {
    final currentText = activeTextFieldData.controller.text;
    int currentCursorOffset =
        activeTextFieldData.controller.selection.baseOffset;
    if (currentCursorOffset < 0) {
      currentCursorOffset = 0;
    }
    activeTextFieldData.controller.text = currentText.replaceRange(
        currentCursorOffset, currentCursorOffset, char);
    activeTextFieldData.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: currentCursorOffset + 1));
  }

  TextFieldData _createTextFieldData(TextFieldFormat format) {
    final controller = TextEditingController();
    final focusNode = FocusNode();
    final data = TextFieldData(
        controller: controller, focusNode: focusNode, format: format);
    return data;
  }

  void deleteAllTextFields() {
    for (final textFieldData in _textFieildsData) {
      textFieldData.controller.dispose();
      textFieldData.focusNode.dispose();
    }
    _textFieldGroops.clear();
    _textFieildsData.clear();
    selectedFieldIndex = 0;
  }

  bool deleteElementFields(bool? checkGroops) {
    if (_textFieildsData.length >= minTextFieldCountToStapBack) {
      final firstDeletedIndex = deleteTextFileds(checkGroops);
      if (_textFieildsData.isEmpty) {
        return false;
      } else {
        if (selectedFieldIndex >= 1 && firstDeletedIndex >= 1) {
          selectedFieldIndex = firstDeletedIndex - 1;
          activeTextFieldData = _textFieildsData[selectedFieldIndex];
        } else {
          selectedFieldIndex = firstDeletedIndex;
          activeTextFieldData = _textFieildsData[selectedFieldIndex];
        }
        return true;
      }
    }
    return false;
  }

  int deleteTextFileds(bool? checkGroops) {
    if (_textFieldGroops.isNotEmpty && checkGroops == true) {
      final findedGroops = findGroops();

      final startField = findedGroops.first.keys.first.startField;
      final start = _textFieildsData.indexOf(startField);
      final endField = findedGroops.first.keys.first.endField;
      final end = _textFieildsData.indexOf(endField);
      for (int i = start; i <= end; i++) {
        _textFieildsData[i].controller.dispose();
        _textFieildsData[i].focusNode.dispose();
      }
      _textFieildsData.removeRange(start, end + 1);
      _textFieldGroops.remove(findedGroops.first.keys.first);
      return start;
    } else {
      _removeActiveTextField(null);
      // selectedFieldIndex -=1;
      return selectedFieldIndex;
    }
  }

  List<Map<TextFieldGroop, int>> findGroops() {
    final findedGroops = <Map<TextFieldGroop, int>>[];
    for (final textFieldGroop in _textFieldGroops) {
      final startIndex =
          _textFieildsData.indexOf(textFieldGroop.startField);
      final endIndex = _textFieildsData.indexOf(textFieldGroop.endField);
      if (selectedFieldIndex >= startIndex && selectedFieldIndex <= endIndex) {
        findedGroops.add({textFieldGroop: endIndex - startIndex});
      }
    }
    findedGroops.sort((a, b) => b.values.first.compareTo(a.values.first));
    return findedGroops;
  }

  bool deleteCurrentController(int fieldLocation) {
    if (_textFieildsData.length <= 1) {
      return false;
    } else {
      if (selectedFieldIndex >= 1) {
        if(fieldLocation == 1) {
          _removeActiveTextField(_textFieildsData[selectedFieldIndex+1]);
        } else { 
          _removeActiveTextField(null);
          selectedFieldIndex -= 1;
        } 
        activeTextFieldData = _textFieildsData[selectedFieldIndex];
      } else {
        if(fieldLocation == 1) {
          _removeActiveTextField(_textFieildsData[selectedFieldIndex+1]);
        } else { 
          _removeActiveTextField(null);
        }
        selectedFieldIndex = 0;
        activeTextFieldData = _textFieildsData[selectedFieldIndex];
      }
    }
    return true;
  }

  void _removeActiveTextField(TextFieldData? newFieldData) {
    activeTextFieldData.controller.dispose();
    activeTextFieldData.focusNode.dispose();
    if( newFieldData != null){
      checkGroops(newFieldData);
    }
    _textFieildsData.remove(activeTextFieldData);
  }

  TextFieldData getTextFieldDataByIndex(int index) {
    return _textFieildsData[index];
  }
  
  void checkGroops(TextFieldData newFieldData) { 
    if(_textFieldGroops.isNotEmpty) {
      final findedGroops = findGroops();
      if (findedGroops.isNotEmpty) {
        final startField = findedGroops.first.keys.first.startField;
        final endField = findedGroops.first.keys.first.endField;
        if( startField == activeTextFieldData){
          findedGroops.first.keys.first.startField = newFieldData;
        } else if( endField == activeTextFieldData){
          findedGroops.first.keys.first.endField = newFieldData;
        }
      }
    }
  }
}

class TextFieldWidgetHandler extends StatefulWidget {
  TextFieldWidgetHandler({
    super.key,
    required this.textFieldData,
    required this.onTextFieldTap,
  });

  final TextFieldData textFieldData;
  final Function(TextFieldData textFieldControllerData) onTextFieldTap;
  TextField? textField;
  String? initTextInField;

  @override
  State<TextFieldWidgetHandler> createState() => _TextFieldWidgetHandlerState();
}

class _TextFieldWidgetHandlerState extends State<TextFieldWidgetHandler> {
  @override
  Widget build(BuildContext context) {
    if (widget.textField == null) {
      widget.textField = TextField(
        textAlign: TextAlign.left,
        focusNode: widget.textFieldData.focusNode,
        style: const TextStyle(fontSize: 20),
        keyboardType: TextInputType.none,
        decoration: textFieldDecoration,
        controller: widget.textFieldData.controller,
        onChanged: (_) {
          setState(() {});
        },
        onTap: () {
          widget.onTextFieldTap(widget.textFieldData);
        },
      );
      if (widget.initTextInField != null) {
        widget.textFieldData.controller.text = widget.initTextInField!;
      }
    }
    final fieldWidget = IntrinsicWidth(
      child: widget.textField,
    );
    return fieldWidget;
  }
}

enum TextFieldFormat {
  standart,
  small,
}

class TextFieldData {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextFieldFormat format;

  TextFieldData({
    required this.controller,
    required this.format,
    required this.focusNode
  });
}

class TextFieldGroop {
  TextFieldData startField;
  TextFieldData endField;

  TextFieldGroop({required this.startField, required this.endField});
}
