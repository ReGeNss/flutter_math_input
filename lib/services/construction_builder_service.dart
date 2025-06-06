import 'package:flutter/material.dart';
import '../interfaces/index.dart';
import '../parsers/index.dart';
import 'index.dart';

class ConstructionBuilderServiceImp implements ConstructionBuilderService {
  final MathConstructionsBuilder _mathConstructionsBuildingService;
  final TextFieldHandleAndCreateService _textFieldService;
  final FormulasTreeParsersService _parsersService;
  final List<Widget> _formulaGroupWidgets;

  ConstructionBuilderServiceImp(
    MathConstructionsBuilder mathConstructionsBuildingService,
    TextFieldHandleAndCreateService textFieldService,
    FormulasTreeParsersService parsersService,
    List<Widget> formulaGroupWidgets,
  )  : _mathConstructionsBuildingService = mathConstructionsBuildingService,
        _textFieldService = textFieldService,
        _parsersService = parsersService,
        _formulaGroupWidgets = formulaGroupWidgets;
        

  @override
  void createComplicatedConstruction(ComplicatedMathConstruction Function(MathConstructionsBuilder p1, {required ParsedWidgetsData parsingResults, required TextFieldHandleAndCreateService textFieldService, required List<Widget> widgetTree}) constructionFactory) {
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
  void createSimpleConstruction(DefaultMathConstruction Function(MathConstructionsBuilder p1) constructionFactory) {
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