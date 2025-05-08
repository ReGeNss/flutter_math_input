import 'index.dart';

abstract class DeleteService extends FormulaStateManager {
  DeleteService(super.updateStream);

  void backspace();
}