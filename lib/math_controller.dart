import 'dart:async';
import 'package:flutter/material.dart';
import 'parsers/index.dart';
import 'services/index.dart';
import 'interfaces/index.dart';

const _timeToUpdateFormula = Duration(seconds: 1);
const _timeToRebuildScreen = Duration(milliseconds: 50);


class MathControllerImpl extends MathController {
  final _textFieldService  = TextFieldHandleAndCreateService(); 
  late final _mathConstructionsBuildingService = MathConstructionsBuilding(
    textFieldService: _textFieldService,
  );  
  final _parsersService = FormulasTreeParsersService(); 
  final _texParsingService = FormulaToTexParser(); 
  late final IDeleteService _deleteService = DeleteService(
    _formulaGroupWidgets,
    _textFieldService,
    _mathConstructionsBuildingService,
    _rebuildController,
  );
  late final ICursorService _focusSelectorService = CursorService(
    _textFieldService,
    _mathConstructionsBuildingService,
    _formulaGroupWidgets,
    _rebuildController,
  );
  late final IConstructionBuilderService _constructionBuilderService = ConstructionBuilderService(
    _mathConstructionsBuildingService,
    _textFieldService,
    _parsersService,
    _formulaGroupWidgets,
  );

  final List<Widget> _formulaGroupWidgets = [];

  final _streamController = StreamController<String>.broadcast();
  final _renderController = StreamController<void>.broadcast();

  bool _isFormulaUpdated = true; 
  bool _isFormulaRendered = true; 

  @override
  Stream<String> get katexFormulaStream => _streamController.stream;
  @override
  bool get isFormulaRendered => _isFormulaRendered;
  @override
  bool get isFormulaUpdated => _isFormulaUpdated;
  final _rebuildController = StreamController<void>();

  MathControllerImpl(){
    _setupStreams();
    _initialization();
  }

  List<Widget> getFormulaWidgets() => _formulaGroupWidgets.toList(); 

  void _initialization(){
    final defaultTextField = _mathConstructionsBuildingService.initialization();
    _formulaGroupWidgets.add(defaultTextField);
  }
  
  void _setupStreams() { 
    Timer? timer;
    _streamController.onListen = () { 
      timer = Timer.periodic(_timeToUpdateFormula, (_) {
        if (!_isFormulaRendered) return;
        _streamController.add(_requestFormulaToKaTeXParse());
      });
    };
    _streamController.onCancel = () {
      timer?.cancel();
    };

    _renderController.stream.listen(
      (_) {
        _isFormulaRendered = !_isFormulaRendered;
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

  FutureOr<String> getFormulaKaTeX() {
    return _isFormulaRendered 
    ? _texParsingService.start(_formulaGroupWidgets) 
    : Future.value(_renderController.stream.first).
      then((_) => _texParsingService.start(_formulaGroupWidgets));
  }

  @override
  void createDefaultFunc(
    DefaultMathConstruction Function(MathConstructionsBuilding) constructionFactory,
  ){
    _constructionBuilderService.createSimpleConstruction(
      constructionFactory,
    );
    _rebuildScreenState();
  }

  @override
  void createComplicatedFunc(
    ComplicatedMathConstruction Function(
      MathConstructionsBuilding, {
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

  void changeFormulaRenderingState(){
    _renderController.add(null);
  }

  @override
  void dispose() {
    _streamController.close();
    _renderController.close(); 
    _textFieldService.dispose();
    _rebuildController.close();
    super.dispose();
  }
}

abstract class FormulaStateManager {
  final StreamController<void> updateStream;

  FormulaStateManager(this.updateStream);

  void requestFormulaUpdate(){
    updateStream.add(null);
  }
}
