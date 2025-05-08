import 'formula_state_manager.dart';

abstract class CursorService extends FormulaStateManager {
  CursorService(super.updateStream);

  void selectNextFocus();
  void selectBackFocus();
  void requestFocusToActiveTextField();
}