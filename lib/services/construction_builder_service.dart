import 'package:flutter/material.dart';
import 'package:flutter_math_input/math_constructions/math_construction.dart';
import 'package:flutter_math_input/parsers/formulas_tree_parsers.dart';
import 'package:flutter_math_input/services/math_constructions_building.dart';
import 'package:flutter_math_input/services/text_field_handle_and_create.dart';
import 'package:flutter_math_input/services/widgets_data_handler.dart';

abstract class IConstructionBuilderService {
  void createComplicatedConstruction(
    ComplicatedMathConstruction Function(
      MathConstructionsBuilding, {
      required TextFieldHandleAndCreateService textFieldService,
      required ParsedWidgetsData parsingResults,
      required List<Widget> widgetTree,
    }) constructionFactory,
  );

  void createSimpleConstruction(
    DefaultMathConstruction Function(MathConstructionsBuilding) constructionFactory,
  );

  void createCharWidgets(String char);
}

class ConstructionBuilderService implements IConstructionBuilderService {
  final MathConstructionsBuilding _mathConstructionsBuildingService;
  final TextFieldHandleAndCreateService _textFieldService;
  final FormulasTreeParsersService _parsersService;
  final List<Widget> _formulaGroupWidgets;

  ConstructionBuilderService(
    MathConstructionsBuilding mathConstructionsBuildingService,
    TextFieldHandleAndCreateService textFieldService,
    FormulasTreeParsersService parsersService,
    List<Widget> formulaGroupWidgets,
  )  : _mathConstructionsBuildingService = mathConstructionsBuildingService,
        _textFieldService = textFieldService,
        _parsersService = parsersService,
        _formulaGroupWidgets = formulaGroupWidgets;
        

  @override
  void createComplicatedConstruction(ComplicatedMathConstruction Function(MathConstructionsBuilding p1, {required ParsedWidgetsData parsingResults, required TextFieldHandleAndCreateService textFieldService, required List<Widget> widgetTree}) constructionFactory) {
     final parsedWidgets = _parsersService.parseWidgetLocation(
      _formulaGroupWidgets, 
      _textFieldService.getActiveTextFieldController(),
    );
    if(parsedWidgets == null || parsedWidgets.index == null) return;
    final construction = constructionFactory(
      _mathConstructionsBuildingService,
      textFieldService: _textFieldService,
      parsingResults: parsedWidgets,
      widgetTree: _formulaGroupWidgets,
    );
    final constructionWidget = construction.createConstruction(); 
    WidgetsDataHandler.replaceWidgetInTree(parsedWidgets, constructionWidget);
  }

  @override
  void createSimpleConstruction(DefaultMathConstruction Function(MathConstructionsBuilding p1) constructionFactory) {
    final construction = constructionFactory(_mathConstructionsBuildingService);
    final parsedWidgets = _parsersService.parseWidgetLocation(
      _formulaGroupWidgets, 
      _textFieldService.getActiveTextFieldController(),
    );
    if(parsedWidgets == null) return;
    final constructionWidget = construction.createConstruction(); 
    WidgetsDataHandler.replaceWidgetInTree(parsedWidgets, constructionWidget);
  }

  @override
  void createCharWidgets(String char) {
    final activeTextFieldController = 
      _textFieldService.getActiveTextFieldController();
    final parsedWidgetData = _parsersService.parseWidgetLocation(
      _formulaGroupWidgets, 
      activeTextFieldController,
    );
    if(parsedWidgetData == null) return;
    final List<Widget> textFields = [];
    if(_textFieldService.getActiveTextFieldController().text.isEmpty){
      _textFieldService.getActiveTextFieldController().text = char; 
    }else{
      textFields.add(_mathConstructionsBuildingService.createCharWidget(
        isActiveTextField: true,
        ),
      );
      _textFieldService.getActiveTextFieldController().text = char; 
    }
    final additionalField = _mathConstructionsBuildingService.createCharWidget(
      isActiveTextField: true,
    );
    textFields.add(additionalField);
    WidgetsDataHandler.addToWidgetTree(parsedWidgetData, textFields);
  }
        
}