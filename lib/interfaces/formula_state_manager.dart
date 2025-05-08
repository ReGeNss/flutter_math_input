import 'dart:async';

abstract class FormulaStateManager {
  final StreamController<void> updateStream;

  FormulaStateManager(this.updateStream);

  void requestFormulaUpdate(){
    updateStream.add(null);
  }
}