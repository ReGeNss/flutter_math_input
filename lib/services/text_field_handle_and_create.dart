// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

const minTextFieldCountToStapBack = 2;

class TextFieldHandleAndCreateService extends ChangeNotifier {
  final List<TextFieldData> _textFieildsData = [];
  final List<TextFieldGroop> _textFieldGroops = [];
  late TextFieldData _activeTextFieldData;
  late int _selectedFieldIndex = 0;

  TextEditingController getActiveTextFieldController() {
    return _activeTextFieldData.controller;
  }

  TextFieldData getPreviousTextFieldDataToActive() {
    return _textFieildsData[_selectedFieldIndex - 1];
  }

  TextFieldData getActiveTextFieldData() {
    return _activeTextFieldData;
  }

  void requestFocusToActiveTextField() {
    _activeTextFieldData.focusNode.requestFocus();
  }

  Widget createTextField(
      {required bool isReplaceOperation,
      TextFieldFormat? selectedTextFieldFormat,
      bool isActiveTextField = false,
      bool performAdictionalTextField = false}) {
    late final TextFieldFormat textFieldFormat;

    if (selectedTextFieldFormat != null) {
      textFieldFormat = selectedTextFieldFormat;
    } else {
      textFieldFormat = _activeTextFieldData.format;
    }
    final textFieldData = _createTextFieldData(textFieldFormat);

    if (isReplaceOperation) {
      _replaceActiveTextFieldByThis(textFieldData);
    } else {
      _insertToList(_textFieildsData, textFieldData, _selectedFieldIndex);
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
          textFieldData: textFieldData,
          onTextFieldTap: onTextFieldTap,
        ));
    return textFiledWidget;
  }

  TextFieldData _createTextFieldData(TextFieldFormat format) {
    final controller = TextEditingController();
    final focusNode = FocusNode();
    final data = TextFieldData(
        controller: controller, focusNode: focusNode, format: format);
    return data;
  }

  void _replaceActiveTextFieldByThis(TextFieldData textFieldData) {
    _textFieildsData[_selectedFieldIndex].focusNode.dispose();
    _textFieildsData[_selectedFieldIndex].controller.dispose();

    _checkGroops(textFieldData);

    _textFieildsData.replaceRange(
        _selectedFieldIndex, _selectedFieldIndex + 1, [textFieldData]);
  }

  void _insertToList<T>(List<T> list, T element, int index) {
    if (list.isNotEmpty) {
      list.insert(index + 1, element);
    } else {
      list.add(element);
    }
  }

  void _addFocusNodeAfterThis(TextFieldData textFieldData) {
    final addictionalTextFieldData =
        _createTextFieldData(TextFieldFormat.standart);
    final index = _textFieildsData.indexOf(textFieldData);
    _textFieildsData.insert(index + 1, addictionalTextFieldData);
  }

  void _makeThisTextFieldActive(TextFieldData textFieldData) {
    _activeTextFieldData = textFieldData;
    _selectedFieldIndex = _textFieildsData.indexOf(_activeTextFieldData);
    Future.delayed(const Duration(milliseconds: 20),
        () => textFieldData.focusNode.requestFocus());
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

  void onTextFieldTap(TextFieldData textFieldData) {
    _selectedFieldIndex = _textFieildsData.indexOf(textFieldData);
    _activeTextFieldData = textFieldData;
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
    _textFieldGroops.add(
      TextFieldGroop(
        startField: _textFieildsData[startIndex],
        endField: _textFieildsData[endIndex]
      )
    );
  }

  bool trySelectNextFocus() {
    final cursorPosition = _activeTextFieldData.controller.selection.baseOffset;
    final textLength = _activeTextFieldData.controller.text.length;
    if (cursorPosition == textLength) {
      final previousIndex = _selectedFieldIndex;
      _selectedFieldIndex = previousIndex + 1;
      if (_textFieildsData.length > _selectedFieldIndex) {
        final focusNode = _textFieildsData[_selectedFieldIndex].focusNode;
        if (focusNode.hasListeners == true) {
          _activeTextFieldData = _textFieildsData[_selectedFieldIndex];
          focusNode.requestFocus();
        } else {
          return false;
        }
      } else {
        _selectedFieldIndex = previousIndex;
      }
    } else {
      _activeTextFieldData.controller.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPosition + 1));
    }
    return true;
  }

  void selectBackFocus() {
    final cursorPosition = _activeTextFieldData.controller.selection.baseOffset;
    if (cursorPosition <= 0) {
      final previousIndex = _selectedFieldIndex;
      _selectedFieldIndex = previousIndex - 1;
      if (_textFieildsData.length > _selectedFieldIndex &&
          _selectedFieldIndex >= 0) {
        _textFieildsData[_selectedFieldIndex].focusNode.requestFocus();
        _activeTextFieldData = _textFieildsData[_selectedFieldIndex];
      } else {
        _selectedFieldIndex = previousIndex;
      }
    } else {
      _activeTextFieldData.controller.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPosition - 1));
    }
  }

  void addCharToTextField(String char) {
    final currentText = _activeTextFieldData.controller.text;
    int currentCursorOffset =
        _activeTextFieldData.controller.selection.baseOffset;
    if (currentCursorOffset < 0) {
      currentCursorOffset = 0;
    }
    _activeTextFieldData.controller.text = currentText.replaceRange(
        currentCursorOffset, currentCursorOffset, char);
    _activeTextFieldData.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: currentCursorOffset + 1));
  }

  void deleteAllTextFields() {
    for (final textFieldData in _textFieildsData) {
      textFieldData.controller.dispose();
      textFieldData.focusNode.dispose();
    }
    _textFieldGroops.clear();
    _textFieildsData.clear();
    _selectedFieldIndex = 0;
  }

  /*
    created to avoid the error when in field we have construction and field,
    when we delete the construction, new field would be created on the place of construction,
    but this field in _textFieldsData would be based in after other field,
    because creating field logic specific would be created in the end of the list
    to fix this, we need to insert this field at the top of the list
  */
  void intertThisFieldToStart(TextFieldData textFieldData) {
    if(_textFieildsData.length == 2){ 
      _textFieildsData.remove(textFieldData); 
      _textFieildsData.insert(0, textFieldData);
      _selectedFieldIndex = 0;
      _activeTextFieldData = textFieldData;
    } 
  }

  bool deleteElementFields(bool? checkGroops) {
    try{
      if (_textFieildsData.isEmpty || _textFieildsData.length < minTextFieldCountToStapBack) {
        return false;
      }

      final firstDeletedIndex = deleteTextFileds(checkGroops);
      if (_textFieildsData.isEmpty) {
        return false;
      }

      _updateSelectedFieldIndex(firstDeletedIndex);
      return true;
    }catch(e){
      return false;
    }
    
  }

  void _updateSelectedFieldIndex(int firstDeletedIndex) {
    if (_selectedFieldIndex >= 1 && firstDeletedIndex >= 1) {
      _selectedFieldIndex = firstDeletedIndex - 1;
    } else {
      _selectedFieldIndex = firstDeletedIndex;
    }
    _activeTextFieldData = _textFieildsData[_selectedFieldIndex];
  }

  int deleteTextFileds(bool? checkGroops) {
    if (_textFieldGroops.isNotEmpty && checkGroops == true) {
      return _deleteGroopFields();
    } 
    _replaceActiveTextField(null);
    return _selectedFieldIndex;
  }

  int _deleteGroopFields() {
    final findedGroops = _findGroops();
    final groopToDelete = findedGroops.first.keys.first;
    
    final start = _textFieildsData.indexOf(groopToDelete.startField);
    final end = _textFieildsData.indexOf(groopToDelete.endField);

    _disposeFieldsInRange(start, end);
    _textFieildsData.removeRange(start, end + 1);
    _textFieldGroops.remove(groopToDelete);

    return start;
  }

  void _disposeFieldsInRange(int start, int end) {
    for (int i = start; i <= end; i++) {
      _textFieildsData[i].controller.dispose();
      _textFieildsData[i].focusNode.dispose();
    }
  }

  List<Map<TextFieldGroop, int>> _findGroops() {
    final findedGroops = <Map<TextFieldGroop, int>>[];
    
    for (final groop in _textFieldGroops) {
      final startIndex = _textFieildsData.indexOf(groop.startField);
      final endIndex = _textFieildsData.indexOf(groop.endField);
      
      if (_isFieldInGroopRange(startIndex, endIndex)) {
        findedGroops.add({groop: endIndex - startIndex});
      }
    }

    findedGroops.sort((a, b) => b.values.first.compareTo(a.values.first));
    return findedGroops;
  }

  bool _isFieldInGroopRange(int startIndex, int endIndex) {
    return _selectedFieldIndex >= startIndex && _selectedFieldIndex <= endIndex;
  }

  bool deleteCurrentController(bool shouldRemarkGroop) {
    try{
      if (_textFieildsData.length <= 1) {
        return false;
      }

      if (shouldRemarkGroop) {
        _replaceActiveTextField(_textFieildsData[_selectedFieldIndex + 1]);
      } else {
        _replaceActiveTextField(null);
        _selectedFieldIndex -= 1;
      }
      
      _activeTextFieldData = _textFieildsData[_selectedFieldIndex];
      return true;
    }catch(e) {
      return false;
    }
    
  }

  void _replaceActiveTextField(TextFieldData? newFieldData) {
    _disposeActiveTextField();
    
    if (newFieldData != null) {
      _checkGroops(newFieldData);
    }
    
    _textFieildsData.remove(_activeTextFieldData);
  }

  void _disposeActiveTextField() {
    _activeTextFieldData.controller.dispose();
    _activeTextFieldData.focusNode.dispose();
  }

  void _checkGroops(TextFieldData newFieldData) {
    if (_textFieldGroops.isEmpty) return;

    final findedGroops = _findGroops();
    if (findedGroops.isEmpty) return;

    final groop = findedGroops.first.keys.first;
    _updateGroopFields(groop, newFieldData);
  }

  void _updateGroopFields(TextFieldGroop groop, TextFieldData newFieldData) {
    if (groop.startField == _activeTextFieldData) {
      groop.startField = newFieldData;
    } else if (groop.endField == _activeTextFieldData) {
      groop.endField = newFieldData;
    }
  }

  void deleteLastChar() {
    final textLength = _activeTextFieldData.controller.text.length;
    _activeTextFieldData.controller.text = _activeTextFieldData.controller.text.substring(0, textLength - 1);
  }

  @override
  void dispose() {
    deleteAllTextFields();
    super.dispose();
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

const textFieldDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(),
  border: InputBorder.none,
  contentPadding: EdgeInsets.all(5)
);

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
