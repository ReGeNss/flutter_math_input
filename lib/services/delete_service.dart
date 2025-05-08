import 'package:flutter/material.dart';
import '../interfaces/index.dart';
import '../parsers/index.dart';
import '../widgets/supportive_widgets/index.dart';
import 'index.dart';

class DeleteServiceImp extends DeleteService {
  final List<Widget> _formulaComponents; 
  final TextFieldHandleAndCreateService _textFieldService; 
  final _parsersService = FormulasTreeParsersService(); // TODO: rename
  final _deletingParserService = FormulasTreeDeletingParser();
  final MathConstructionsBuilder _mathConstructionsBuildingService;

  DeleteServiceImp(
    List<Widget> formulasElementsWidgets,
    TextFieldHandleAndCreateService textFieldService,
    MathConstructionsBuilder mathConstructionsBuildingService,
    super.updateStream,
  ) : _formulaComponents = formulasElementsWidgets,
      _textFieldService = textFieldService,
      _mathConstructionsBuildingService = mathConstructionsBuildingService;

  @override
  void backspace() {
    final activeController = _textFieldService.getActiveTextFieldController();
    
    if (_canDeleteCharFromCurrentField(activeController)) {
      _textFieldService.deleteLastChar();
    } else { 
      _handleEmptyFieldDeletion(activeController);
    }
  }

  bool _canDeleteCharFromCurrentField(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }

  void _handleEmptyFieldDeletion(TextEditingController activeController) {
    final parsedWidgets = _parsersService.parseWidgetLocation(
      _formulaComponents, 
      activeController,
    );
    
    if (parsedWidgets == null) {
      return;
    }

    final fieldsCountInConstruction = _getFieldsCountInConstruction(
      parsedWidgets, 
      activeController,
    );
    
    if(fieldsCountInConstruction == null) {
      _replaceElementByField(activeController);
      requestFormulaUpdate();

      return;
    }

    if (fieldsCountInConstruction.fieldsCount > 1) {
      _deleteFieldOrGroup(
        parsedWidgets, 
        fieldsCountInConstruction.ourFieldLocation == 1,
      );
    } else {
      _replaceElementByField(activeController);
    }

    requestFormulaUpdate();
  }

  ElementFieldsData? _getFieldsCountInConstruction(
    ParsedWidgetsData parsedWidgets, 
    TextEditingController activeController,
  ) {
    return _deletingParserService.getCountOfTextFieldsIn(
      parsedWidgets.widgetData!, 
      activeController,
    );
  }

  void _deleteFieldOrGroup(
    ParsedWidgetsData parsedWidgets, 
    bool shouldRemarkGroup,
  ) {
    _textFieldService.deleteCurrentController(
      shouldRemarkGroup:  shouldRemarkGroup,
    );
    WidgetsDataHandler.deleteFromWidgetTree(parsedWidgets);
  }

  void _replaceElementByField(TextEditingController activeController) {
    final elementToReplace = _deletingParserService.getElement(
      _formulaComponents, 
      activeController,
    );

    _textFieldService.deleteElementFields(checkGroups: elementToReplace?.isGroup);

    if (elementToReplace != null) {
      final shouldMoveToFirst = elementToReplace.index == 0;
      _replaceWithNewField(elementToReplace, shouldMoveToFirst);
    } else {
      _removeCurrentField(activeController);
    }
  }

  void _replaceWithNewField(
    ParsedWidgetsData elementToReplace, 
    bool moveToFirst,
  ) {
    final newField = _mathConstructionsBuildingService.createTextField(
      isActive: true,
      format: TextFieldFormat.standard,
    );
    if(moveToFirst) {
      final textFieldData = (
        (newField as SizedBox).child! as TextFieldWrapper
      ).textFieldData;
      _textFieldService.insertThisFieldToStart(textFieldData);
    }
    WidgetsDataHandler.replaceWidgetInTree(
      elementToReplace,
      MathConstructionWidgetData(construction: newField),
    );
  }

  void _removeCurrentField(TextEditingController activeController) {
    final dataToReplaceField = _parsersService.parseWidgetLocation(
      _formulaComponents,
      activeController,
    );
    
    if (dataToReplaceField != null) {
      WidgetsDataHandler.deleteFromWidgetTree(dataToReplaceField);
    }
  }

}