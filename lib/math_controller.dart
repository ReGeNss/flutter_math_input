import 'dart:async';
import 'package:flutter/material.dart';
import 'parsers/index.dart';
import 'services/index.dart';
import 'interfaces/index.dart';

const _timeToUpdateFormula = Duration(seconds: 1);
const _timeToRebuildScreen = Duration(milliseconds: 50);


class MathControllerImpl extends MathController {
  final _textFieldService  = TextFieldHandleAndCreateService(); 
  late final _mathConstructionsBuildingService = MathConstructionsBuilder(
    textFieldService: _textFieldService,
  );  
  final _parsersService = FormulasTreeParsersService(); 
  final _texParsingService = FormulaToTexParser(); 
  late final DeleteService _deleteService = DeleteServiceImp(
    _formulaGroupWidgets,
    _textFieldService,
    _mathConstructionsBuildingService,
    _rebuildController,
  );
  late final CursorService _focusSelectorService = CursorImp(
    _textFieldService,
    _mathConstructionsBuildingService,
    _formulaGroupWidgets,
    _rebuildController,
  );
  late final ConstructionBuilderService _constructionBuilderService = ConstructionBuilderServiceImp(
    _mathConstructionsBuildingService,
    _textFieldService,
    _parsersService,
    _formulaGroupWidgets,
  );

  final List<Widget> _formulaGroupWidgets = [];

  final _formulaStreamController = StreamController<String>.broadcast();
  final _renderController = StreamController<void>.broadcast();

  bool _isFormulaUpdated = true; 
  bool _isFormulaRendered = true; 

  @override
  Stream<String> get katexFormulaStream => _formulaStreamController.stream;
  @override
  bool get isFormulaRendered => _isFormulaRendered;
  @override
  bool get isFormulaUpdated => _isFormulaUpdated;
  final _rebuildController = StreamController<void>();

  MathControllerImpl(){
    _setupStreams();
    _initialization();
  }

  @override
  List<Widget> getFormulaWidgets() => _formulaGroupWidgets.toList(); 

  void _initialization(){
    final defaultTextField = _mathConstructionsBuildingService.initialization();
    _formulaGroupWidgets.add(defaultTextField);
  }
  
  void _setupStreams() { 
    _formulaStreamController.onListen = () { 
      
    };
    _formulaStreamController.onCancel = () {
    };

    _renderController.stream.listen(
      (_) {
        _isFormulaRendered = !_isFormulaRendered;
        if(_isFormulaRendered){
          _formulaStreamController.add(_requestFormulaToKaTeXParse());
        }
      }
    );

    _rebuildController.stream.listen((_) {
      _rebuildScreenState();
    });
  }

  @override
  void addCharToTextField(String char){
    _textFieldService.addCharToTextField(char);
  }

  String _requestFormulaToKaTeXParse() {
      return _texParsingService.start(_formulaGroupWidgets);
  }

  @override
  FutureOr<String> getFormulaKaTeX() {
    return _isFormulaRendered 
    ? _texParsingService.start(_formulaGroupWidgets) 
    : Future.value(_renderController.stream.first).
      then((_) => _texParsingService.start(_formulaGroupWidgets));
  }

  @override
  void createDefaultFunc(
    DefaultMathConstruction Function(MathConstructionsBuilder) constructionFactory,
  ){
    _constructionBuilderService.createSimpleConstruction(
      constructionFactory,
    );
    _rebuildScreenState();
  }

  @override
  void createComplicatedFunc(
    ComplicatedMathConstruction Function(
      MathConstructionsBuilder, {
      required TextFieldHandleAndCreateService textFieldService,
      required ParsedWidgetsData parsingResults,
      required List<Widget> widgetTree,
    }) constructionFactory,
  ){
    _constructionBuilderService.createComplicatedConstruction(
      constructionFactory,
    );
    _rebuildScreenState();
  }

  @override
  void createCharWidgets(String char){
    _constructionBuilderService.createCharWidgets(char);
    _rebuildScreenState();
  }

  @override
  void selectCursorForward(){
    _focusSelectorService.selectNextFocus();
  }

  @override
  void selectCursorBack(){
    _focusSelectorService.selectBackFocus(); 
  }

  @override
  void backspaceButtonTap(){
    try{
      _deleteService.backspace();
    } catch (e){
      deleteAllButtonTap(); 
    }
  }
  
  @override
  void deleteAllButtonTap() {
    _formulaGroupWidgets.clear();
    _textFieldService.deleteAllTextFields();
    _initialization();
    notifyListeners();
  }

  void _rebuildScreenState() {
    _isFormulaUpdated = false;
    changeFormulaRenderingState();
    notifyListeners();
        
    Future.delayed(_timeToRebuildScreen, () {
      _isFormulaUpdated = true;
      notifyListeners();
      _textFieldService.requestFocusToActiveTextField();
    });
  }

  @override
  void changeFormulaRenderingState(){
    _renderController.add(null);
  }

  @override
  void dispose() {
    _formulaStreamController.close();
    _renderController.close(); 
    _textFieldService.dispose();
    _rebuildController.close();
    super.dispose();
  }
}
