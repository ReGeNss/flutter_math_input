// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

const minTextFieldCountToStepBack = 2;

class TextFieldHandleAndCreateService extends ChangeNotifier {
  final List<TextFieldData> _textFieldsData = [];
  final List<TextFieldGroup> _textFieldGroups = [];
  late TextFieldData _activeTextFieldData;
  late int _selectedFieldIndex = 0;

  TextEditingController getActiveTextFieldController() {
    return _activeTextFieldData.controller;
  }

  TextFieldData getPreviousTextFieldDataToActive() {
    return _textFieldsData[_selectedFieldIndex - 1];
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
      bool performAdditionalTextField = false,}) {
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
      _insertToList(_textFieldsData, textFieldData, _selectedFieldIndex);
    }

    if (performAdditionalTextField) {
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
        ),);
    return textFiledWidget;
  }

  TextFieldData _createTextFieldData(TextFieldFormat format) {
    final controller = TextEditingController();
    final focusNode = FocusNode();
    final data = TextFieldData(
        controller: controller, focusNode: focusNode, format: format,);
    return data;
  }

  void _replaceActiveTextFieldByThis(TextFieldData textFieldData) {
    _textFieldsData[_selectedFieldIndex].focusNode.dispose();
    _textFieldsData[_selectedFieldIndex].controller.dispose();

    _checkGroups(textFieldData);

    _textFieldsData.replaceRange(
        _selectedFieldIndex, _selectedFieldIndex + 1, [textFieldData],);
  }

  void _insertToList<T>(List<T> list, T element, int index) {
    if (list.isNotEmpty) {
      list.insert(index + 1, element);
    } else {
      list.add(element);
    }
  }

  void _addFocusNodeAfterThis(TextFieldData textFieldData) {
    final additionalTextFieldData =
        _createTextFieldData(TextFieldFormat.standard);
    final index = _textFieldsData.indexOf(textFieldData);
    _textFieldsData.insert(index + 1, additionalTextFieldData);
  }

  void _makeThisTextFieldActive(TextFieldData textFieldData) {
    _activeTextFieldData = textFieldData;
    _selectedFieldIndex = _textFieldsData.indexOf(_activeTextFieldData);
    Future.delayed(const Duration(milliseconds: 20),
        () => textFieldData.focusNode.requestFocus(),);
  }

  Size _selectTextFieldFormat(TextFieldFormat format) {
    final Size size;
    if (format == TextFieldFormat.standard) {
      size = const Size(60, 50);
    } else if (format == TextFieldFormat.small) {
      size = const Size(40, 30);
    } else {
      size = const Size(60, 50);
    }
    return size;
  }

  void onTextFieldTap(TextFieldData textFieldData) {
    _selectedFieldIndex = _textFieldsData.indexOf(textFieldData);
    _activeTextFieldData = textFieldData;
  }

  void markAsGroup(dynamic startFieldData, Widget endFieldBox) {
    late final int startIndex;
    if (startFieldData is SizedBox) {
      final startField = startFieldData.child! as TextFieldWidgetHandler;
      startIndex = _textFieldsData.indexOf(startField.textFieldData);
    } else if (startFieldData is TextFieldData) {
      startIndex = _textFieldsData.indexOf(startFieldData);
    }
    final endField = (endFieldBox as SizedBox).child! as TextFieldWidgetHandler;
    final endIndex = _textFieldsData.indexOf(endField.textFieldData);
    _textFieldGroups.add(
      TextFieldGroup(
        startField: _textFieldsData[startIndex],
        endField: _textFieldsData[endIndex],
      ),
    );
  }

  bool trySelectNextFocus() {
    final cursorPosition = _activeTextFieldData.controller.selection.baseOffset;
    final textLength = _activeTextFieldData.controller.text.length;
    if (cursorPosition == textLength) {
      final previousIndex = _selectedFieldIndex;
      _selectedFieldIndex = previousIndex + 1;
      if (_textFieldsData.length > _selectedFieldIndex) {
        final focusNode = _textFieldsData[_selectedFieldIndex].focusNode;
        if (focusNode.hasListeners == true) {
          _activeTextFieldData = _textFieldsData[_selectedFieldIndex];
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
      if (_textFieldsData.length > _selectedFieldIndex &&
          _selectedFieldIndex >= 0) {
        _textFieldsData[_selectedFieldIndex].focusNode.requestFocus();
        _activeTextFieldData = _textFieldsData[_selectedFieldIndex];
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
        currentCursorOffset, currentCursorOffset, char,);
    _activeTextFieldData.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: currentCursorOffset + 1),);
  }

  void deleteAllTextFields() {
    for (final textFieldData in _textFieldsData) {
      textFieldData.controller.dispose();
      textFieldData.focusNode.dispose();
    }
    _textFieldGroups.clear();
    _textFieldsData.clear();
    _selectedFieldIndex = 0;
  }

  /*
    created to avoid the error when in field we have construction and field,
    when we delete the construction,
    new field would be created on the place of construction,
    but this field in _textFieldsData would be based in after other field,
    because creating field logic specific
    would be created in the end of the list
    to fix this, we need to insert this field at the top of the list
  */
  void insertThisFieldToStart(TextFieldData textFieldData) {
    if(_textFieldsData.length == 2){ 
      _textFieldsData.remove(textFieldData); 
      _textFieldsData.insert(0, textFieldData);
      _selectedFieldIndex = 0;
      _activeTextFieldData = textFieldData;
    } 
  }

  bool deleteElementFields({bool? checkGroups}) {
    try{
      if (_textFieldsData.isEmpty || 
        _textFieldsData.length < minTextFieldCountToStepBack
      ) {
        return false;
      }

      final firstDeletedIndex = deleteTextFields(checkGroups: checkGroups);
      if (_textFieldsData.isEmpty) {
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
    _activeTextFieldData = _textFieldsData[_selectedFieldIndex];
  }

  int deleteTextFields({bool? checkGroups}) {
    if (_textFieldGroups.isNotEmpty && (checkGroups ?? false)) {
      return _deleteGroupFields();
    } 
    _replaceActiveTextField(null);
    
    return _selectedFieldIndex;
  }

  int _deleteGroupFields() {
    final foundedGroups = _findGroups();
    final groupToDelete = foundedGroups.first.keys.first;
    
    final start = _textFieldsData.indexOf(groupToDelete.startField);
    final end = _textFieldsData.indexOf(groupToDelete.endField);

    _disposeFieldsInRange(start, end);
    _textFieldsData.removeRange(start, end + 1);
    _textFieldGroups.remove(groupToDelete);

    return start;
  }

  void _disposeFieldsInRange(int start, int end) {
    for (int i = start; i <= end; i++) {
      _textFieldsData[i].controller.dispose();
      _textFieldsData[i].focusNode.dispose();
    }
  }

  List<Map<TextFieldGroup, int>> _findGroups() {
    final foundedGroups = <Map<TextFieldGroup, int>>[];
    
    for (final group in _textFieldGroups) {
      final startIndex = _textFieldsData.indexOf(group.startField);
      final endIndex = _textFieldsData.indexOf(group.endField);
      
      if (_isFieldInGroupRange(startIndex, endIndex)) {
        foundedGroups.add({group: endIndex - startIndex});
      }
    }

    foundedGroups.sort((a, b) => b.values.first.compareTo(a.values.first));

    return foundedGroups;
  }

  bool _isFieldInGroupRange(int startIndex, int endIndex) {
    return _selectedFieldIndex >= startIndex && _selectedFieldIndex <= endIndex;
  }

  bool deleteCurrentController({required bool shouldRemarkGroup}) {
    try{
      if (_textFieldsData.length <= 1) {
        return false;
      }

      if (shouldRemarkGroup) {
        _replaceActiveTextField(_textFieldsData[_selectedFieldIndex + 1]);
      } else {
        _replaceActiveTextField(null);
        _selectedFieldIndex -= 1;
      }
      
      _activeTextFieldData = _textFieldsData[_selectedFieldIndex];

      return true;
    }catch(e) {
      return false;
    }
    
  }

  void _replaceActiveTextField(TextFieldData? newFieldData) {
    _disposeActiveTextField();
    
    if (newFieldData != null) {
      _checkGroups(newFieldData);
    }
    
    _textFieldsData.remove(_activeTextFieldData);
  }

  void _disposeActiveTextField() {
    _activeTextFieldData.controller.dispose();
    _activeTextFieldData.focusNode.dispose();
  }

  void _checkGroups(TextFieldData newFieldData) {
    if (_textFieldGroups.isEmpty) return;

    final foundedGroups = _findGroups();
    if (foundedGroups.isEmpty) return;

    final group = foundedGroups.first.keys.first;
    _updateGroupFields(group, newFieldData);
  }

  void _updateGroupFields(TextFieldGroup group, TextFieldData newFieldData) {
    if (group.startField == _activeTextFieldData) {
      group.startField = newFieldData;
    } else if (group.endField == _activeTextFieldData) {
      group.endField = newFieldData;
    }
  }

  void deleteLastChar() {
    final textLength = _activeTextFieldData.controller.text.length;
    _activeTextFieldData.controller.text =
      _activeTextFieldData.controller.text.substring(0, textLength - 1);
  }

  @override
  void dispose() {
    deleteAllTextFields();
    super.dispose();
  } 
}

class TextFieldWidgetHandler extends StatefulWidget {
  TextFieldWidgetHandler({
    required this.textFieldData,
    required this.onTextFieldTap,
    super.key,
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
  contentPadding: EdgeInsets.all(5),
);

enum TextFieldFormat {
  standard,
  small,
}

class TextFieldData {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextFieldFormat format;

  TextFieldData({
    required this.controller,
    required this.format,
    required this.focusNode,
  });
}

class TextFieldGroup {
  TextFieldData startField;
  TextFieldData endField;

  TextFieldGroup({required this.startField, required this.endField});
}
