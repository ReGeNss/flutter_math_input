import 'package:flutter/material.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

class FormulaToTexParser {
  String formulaInTeX = '';
  String start(List<Widget> widgetList) {
    try{
      formulaInTeX = '';
      _formulaParser(widgetList);
      return formulaInTeX;
    }catch(e){
      return '\\text{something went wrong, retry...}';
    }
  }

  String? _formulaParser(List<Widget> widgetList) {
    for (final element in widgetList) {
      switch (element.runtimeType) {
        case const (Row):
          {
            element as Row;
            if (
              element.key != null &&
              element.key.runtimeType != LabeledGlobalKey<State<StatefulWidget>>
              ) {
              final keyValue = ((element.key as ObjectKey).value as MathConstructionKey);
              switch (keyValue.type) {
                case (ElementsType.exponentiationElement):
                  {
                    return addToTeXData(
                      widgets: element.children,
                      parseFunctionByChildren: expParser
                    );
                  }
                case (ElementsType.indefiniteIntegralElement):
                  {
                    addToTeXData(
                      widgets: element.children,
                      parseFunctionByChildren: undefinitIntegralParser
                    );
                  }
                default:
              }
            } else {
              final intermediateTeXData = formulaInTeX;
              formulaInTeX = '';
              _formulaParser(element.children);
              formulaInTeX = intermediateTeXData + formulaInTeX;
              return formulaInTeX;
            }
            break;
          }
        case const (Column):
          {
            element as Column;
            if (element.key != null) {
              final key = (element.key as ObjectKey).value as MathConstructionKey;
              if (key.type == ElementsType.fracElement) {
                final fracString = fracParser(element.children);
                formulaInTeX = formulaInTeX + fracString;
              } 
            }

            break;
          }
        case const (Stack):
          {
            element as Stack;
            if (element.children.isNotEmpty) {
              _formulaParser(element.children);
              return formulaInTeX ;
            }
            break;
          }
        case const (SizedBox):
          {
            element as SizedBox;
            if (element.child != null) {
              if (element.key != null && element.key is ObjectKey) {
                final key = element.key as ObjectKey;
                final keyValue = key.value as MathConstructionKey;
                switch (keyValue.type) {
                  case (ElementsType.absElement):
                    {
                      addToTeXData(
                        widget: element.child!,
                        parseFunctionByChild: absParser
                      );
                    }
                  case (ElementsType.sqrtElement):
                    {
                      if(element.child != null){
                        addToTeXData(
                          widgets: [element.child!],
                          parseFunctionByChildren: sqrtParser
                        );
                      }
                    }
                    case (ElementsType.cosElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\cos'
                    );
                  }
                case (ElementsType.sinElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\sin'
                    );
                  }
                case (ElementsType.tanElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\tan'
                    );
                  }
                case (ElementsType.cotElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\cot'
                    );
                  }
                case (ElementsType.arccosElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\arccos'
                    );
                  }
                case (ElementsType.arcsinElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\arcsin'
                    );
                  }
                case (ElementsType.arctanElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\arctan'
                    );
                  }
                case (ElementsType.arccotElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\arcctg'
                    );
                  }
                case (ElementsType.naturalLogElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\ln'
                    );
                  }
                case (ElementsType.logBaseTwoElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\log_2'
                    );
                  }
                case (ElementsType.decimalLogElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\lg'
                    );
                  }
                case (ElementsType.derevativeElement):
                  {
                    addToTeXData(widget: element.child!, parseFunctionByChild: derevativeParser);
                  }
                default:
              }
              } else {
                _formulaParser([element.child!]);
              }
            }

            break;
          }
        case const (Positioned):
          {
            element as Positioned;
            _formulaParser([element.child]);
            break;
          }
        case const (TextField):
          {
            element as TextField;
            formulaInTeX = formulaInTeX + element.controller!.text;
            return element.controller?.text;
          }
        case const (BacketsWidget):
          {
            element as BacketsWidget;
            addToTeXData(
                widgets: [element.child!], parseFunctionByChildren: backetsParer);
            break;
          }
        case const (ArgumentWidget):
          {
            element as ArgumentWidget;
            _formulaParser([element.child!]);
            break;
          }
        case const (TextFieldWidgetHandler):
          {
            element as TextFieldWidgetHandler;
            return _formulaParser([element.textField!]);
          }
        case const (RelayedPositioned):
          {
            element as RelayedPositioned;
            _formulaParser([element.wrappedWidget!]);
            break;
          }
        case const (WidgetDynamicSizeWrapper): 
        {
          element as WidgetDynamicSizeWrapper;
          if(element.key != null && element.key is ObjectKey){
            final key = element.key as ObjectKey;
            final keyValue = key.value as MathConstructionKey;
            switch(keyValue.type){
              case (ElementsType.limitElement):
              {
                addToTeXData(
                  widget: element.wrappedWidget,
                  parseFunctionByChild: limitParser
                );
              }
              case (ElementsType.integralElement):
              {
                addToTeXData(
                  widget: element.wrappedWidget,
                  parseFunctionByChild: integralParser
                );
              }
              case (ElementsType.logElement):
              {
                addToTeXData(widget: element.wrappedWidget, parseFunctionByChild: logParser);
              }
              default:
            }
          }else{
            _formulaParser([element.wrappedWidget]);
          }
          break;
        }
      }
    }
    return null;
  }

  String addToTeXData({
      Function(List<Widget>)? parseFunctionByChildren,
      Function(Widget)? parseFunctionByChild,
      List<Widget>? widgets,
      Widget? widget,
      Function(List<Widget>, String)? parseFunctionWithTeXFormula,
      String? teXFormula
    }) {
    final intermediateTeXData = formulaInTeX;
    formulaInTeX = '';
    var teXData = '';
    if (parseFunctionByChildren != null && widgets != null) {
      teXData = parseFunctionByChildren(widgets) as String;
    } else if (teXFormula != null && parseFunctionWithTeXFormula != null && widgets != null) {
      teXData = parseFunctionWithTeXFormula(widgets, teXFormula) as String;
    } else if( parseFunctionByChild != null && widget != null){
      teXData = parseFunctionByChild(widget) as String;
    }
    formulaInTeX = intermediateTeXData + teXData;
    return formulaInTeX;
  }

  String backetsParer(List<Widget> widgets) {
    String backetData = '';
    for (final element in widgets) {
      _formulaParser([element]); 
      if (formulaInTeX.isNotEmpty) {
        backetData = '$backetData$formulaInTeX';
      }
      formulaInTeX = '';
    }
    return '\\left($backetData\\right)';
  }

  String expParser(List<Widget> widgets) {
    String teXExpData = '';
    for (final element in widgets) {
      formulaInTeX = '';
      _formulaParser([element]);
      if (formulaInTeX.isNotEmpty) {
        teXExpData = '$teXExpData$formulaInTeX ';
      }
    }
    return '^{$teXExpData}';
  }

  List<String> getFormulasFromWidgets(List<Widget> widgets, List<int> widgetsTocheck){
    List<String> data = [];
    for(int i = 0; i < widgetsTocheck.length; i++){
      _formulaParser([widgets[widgetsTocheck[i]]]);
      data.add(formulaInTeX);
      formulaInTeX = '';
    }
    return data;
  }

  String sqrtParser(List<Widget> widgets) {
    String textData = '';
    for (final element in widgets) {
      _formulaParser([element]);
      textData = '$textData$formulaInTeX';
      formulaInTeX = '';
    }
    final teXSqrtData = '\\sqrt{$textData}';
    return teXSqrtData;
  }

  String fracParser(List<Widget> widgets) {
    final fracData = getFormulasFromWidgets(widgets, [0, 2]); 
    final fracStringData = '\\frac{${fracData[0]}}{${fracData[1]}} ';
    return fracStringData;
  }

  String derevativeParser(Widget widget) {
    final widgets = (widget as Column).children;
    final derevativeData = getFormulasFromWidgets(widgets, [0, 2]);
    final derevativeString =
        '\\frac{d${derevativeData[0]}}{d${derevativeData[1]}} ';
    return derevativeString;
  }

  String logParser(Widget widget) {
    final widgets = (widget as Stack).children;
    final logData = getFormulasFromWidgets(widgets, [1, 2]);
    final logStringData = '\\log_{${logData[1]}}${logData[0]} ';
    return logStringData;
  }

  String integralParser(Widget widget) {
    final stack = widget as Stack;
    final integralData = getFormulasFromWidgets(stack.children, [1, 2, 3, 5]);
    final integralString =
        '\\int_{${integralData[0]}}^{${integralData[1]}} ${integralData[2]} d${integralData[3]} ';
    return integralString;
  }

  String undefinitIntegralParser(List<Widget> widgets) {
    final integralData = getFormulasFromWidgets(widgets, [1, 3]);
    final integral = '\\int ${integralData[0]} d${integralData[1]} ';
    return integral;
  }

  String absParser(Widget widget) {
    if (widget is Row) {
      final fieldData = _formulaParser(widget.children);
      formulaInTeX = '';
      return '\\left| $fieldData \\right|';
    }
    return '';
  }

  String limitParser(Widget widget) {
    final stack = widget as Stack;
    final limitData = getFormulasFromWidgets(stack.children, [1, 2, 4]);
    final limitStringData = '\\lim_{${limitData[1]}\\to ${limitData[2]}} ${limitData[0]} ';
    return limitStringData;
  }

  String trigonometricParser(List<Widget> widgets, String teXFormula) {
    var stringData = '';
    formulaInTeX = '';
    for (final element in widgets) {
      if (element is MultiChildRenderObjectWidget) {
        _formulaParser(element.children);
          stringData = '$stringData$formulaInTeX ';
      }else if(element is SingleChildRenderObjectWidget) {
        _formulaParser([element.child!]);
          stringData = '$stringData$formulaInTeX';
      }
      formulaInTeX = '';
    }
    return '$teXFormula$stringData';
  }
}
