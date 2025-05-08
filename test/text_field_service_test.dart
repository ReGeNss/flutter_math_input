import 'package:flutter/material.dart';
import 'package:flutter_math_input/services/text_field_handle_and_create.dart';
import 'package:flutter_math_input/widgets/supportive_widgets/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Focus tests', () {
    testWidgets('Last field should have focus', (WidgetTester tester) async {
      final textFieldService = TextFieldHandleAndCreateService();
      final widgets = generateActiveTextFields(5, textFieldService);
      final testWidget = widgets[4];
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: testWidget)));

      textFieldService.selectBackFocus();
      await tester.pumpAndSettle();
      final hasFocus = testWidget.textFieldData.focusNode.hasFocus;
      expect(hasFocus, isTrue);
    });

    testWidgets('Select back test', (WidgetTester tester) async {
      final textFieldService = TextFieldHandleAndCreateService();
      final widgets = generateActiveTextFields(5, textFieldService);

      final testWidget = widgets[2];
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: testWidget)));

      textFieldService.selectBackFocus();
      textFieldService.selectBackFocus();
      await tester.pumpAndSettle();
      expect(testWidget.textFieldData.focusNode.hasFocus, isTrue);
    });

    testWidgets('Select forward test', (WidgetTester tester) async {
      final textFieldService = TextFieldHandleAndCreateService();
      final widgets = generateActiveTextFields(5, textFieldService);

      final testWidget = widgets[2];
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: testWidget)));
      textFieldService.selectBackFocus();
      textFieldService.selectBackFocus();

      textFieldService.trySelectNextFocus();
      textFieldService.trySelectNextFocus();
      await tester.pumpAndSettle();
      expect(testWidget.textFieldData.focusNode.hasFocus, isTrue);
    });

    testWidgets('Select more than can', (WidgetTester tester) async {
      final textFieldService = TextFieldHandleAndCreateService();
      final widgets = generateActiveTextFields(5, textFieldService);

      final testWidget = widgets[4];
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: testWidget)));

      textFieldService.trySelectNextFocus();
      textFieldService.trySelectNextFocus();
      textFieldService.trySelectNextFocus();
      textFieldService.trySelectNextFocus();
      await tester.pumpAndSettle();
      expect(testWidget.textFieldData.focusNode.hasFocus, isTrue);
    });

    testWidgets('Delete field', (WidgetTester tester) async {
      final textFieldService = TextFieldHandleAndCreateService();
      final widgets = generateActiveTextFields(5, textFieldService);

      final testWidget = widgets[2];
      textFieldService.selectBackFocus();
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: testWidget)));

      textFieldService.deleteCurrentController(shouldRemarkGroup: false);
      textFieldService.requestFocusToActiveTextField();
      await tester.pumpAndSettle();
      expect(testWidget.textFieldData.focusNode.hasFocus, isTrue);
    });

    testWidgets('Delete fields group', (WidgetTester tester) async {
      final textFieldService = TextFieldHandleAndCreateService();
      final widgets = generateActiveTextFields(5, textFieldService);

      final testWidget = widgets[2];
      textFieldService.markAsGroup(
        SizedBox(child: widgets[3]), 
        SizedBox(child: widgets[4]),
      ); 
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: testWidget)));

      textFieldService.deleteElementFields(checkGroups: true);
      textFieldService.requestFocusToActiveTextField();
      await tester.pumpAndSettle();
      expect(testWidget.textFieldData.focusNode.hasFocus, isTrue);
    });

    testWidgets('Delete fields group', (WidgetTester tester) async {
      final textFieldService = TextFieldHandleAndCreateService();
      final widgets = generateActiveTextFields(5, textFieldService);

      final testWidget = widgets[1];
      textFieldService.markAsGroup(SizedBox(
        child: widgets[2],), 
        SizedBox(child: widgets[4]),
      ); 
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: testWidget)));
      
      textFieldService.selectBackFocus();
      textFieldService.selectBackFocus();
      textFieldService.deleteCurrentController(shouldRemarkGroup: true); 
      textFieldService.deleteElementFields(checkGroups: true);
      textFieldService.requestFocusToActiveTextField();
      await tester.pumpAndSettle();
      expect(testWidget.textFieldData.focusNode.hasFocus, isTrue);
    });
  });
}

List<TextFieldWrapper> generateActiveTextFields(
  int count, 
  TextFieldHandleAndCreateService textFieldService,
) { 
  final List<TextFieldWrapper> textFields = []; 
  for (var i = 0; i < count; i++) {
    textFields.add((textFieldService.createTextField(
      isReplaceOperation: false,
      isActiveTextField: true,
      selectedTextFieldFormat: TextFieldFormat.standard,
    ) as SizedBox).child! as TextFieldWrapper,);
  }
  return textFields;
}
