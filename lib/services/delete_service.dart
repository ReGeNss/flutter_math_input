import 'package:flutter/material.dart';
import 'package:flutter_math_input/math_controller.dart';
import 'package:flutter_math_input/math_constructions/math_construction.dart';
import 'package:flutter_math_input/parsers/deleting_parser.dart';
import 'package:flutter_math_input/services/math_constructions_building.dart';
import 'package:flutter_math_input/services/text_field_handle_and_create.dart';
import 'package:flutter_math_input/services/widgets_data_handler.dart';

import '../parsers/formulas_tree_parsers.dart';

abstract class IDeleteService extends FormulaStateManager {
  IDeleteService(super.updateStream);

  void backspace();
}

class DeleteService extends IDeleteService {
  final List<Widget> _formulaComponents; 
  final TextFieldHandleAndCreateService _textFieldService; 
  final _parsersService = FormulasTreeParsersService(); // TODO: rename
  final _deletingParserService = FormulasTreeDeletingParser();
  final MathConstructionsBuilding _mathConstructionsBuildingService;

  DeleteService(
    List<Widget> formulasElementsWidgets,
    TextFieldHandleAndCreateService textFieldService,
    MathConstructionsBuilding mathConstructionsBuildingService,
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
    final isSuccess = _textFieldService.deleteCurrentController(
      shouldRemarkGroup:  shouldRemarkGroup,
    );
    
    if (isSuccess) {
      WidgetsDataHandler.deleteFromWidgetTree(parsedWidgets);
    } else {
      throw Exception(); 
    }
  }

  void _replaceElementByField(TextEditingController activeController) {
    final elementToReplace = _deletingParserService.getElement(
      _formulaComponents, 
      activeController,
    );

    if (!_tryDeleteControllers(elementToReplace?.isGroup)) {
      throw Exception();
    }

    if (elementToReplace != null) {
      final shouldMoveToFirst = elementToReplace.index == 0;
      _replaceWithNewField(elementToReplace, shouldMoveToFirst);
    } else {
      _removeCurrentField(activeController);
    }
  }

  bool _tryDeleteControllers(bool? isGroup) {
    return _textFieldService.deleteElementFields(checkGroups: isGroup);
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
        (newField as SizedBox).child! as TextFieldWidgetHandler
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