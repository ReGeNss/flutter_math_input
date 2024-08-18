import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';

class FormulaToTexParser{
  String formulaInTeX = '';
  void start(List<Widget> widgetList){
    _formulaParser(widgetList);
    print(formulaInTeX);
    formulaInTeX= ''; 
  }

  String? _formulaParser(List<Widget> widgetList) {
  for (final element in widgetList) {
    switch (element.runtimeType) {
      case const (Row):
        {
          element as Row;
          if (element.key != null && element.key.runtimeType != LabeledGlobalKey<State<StatefulWidget>>) {
            final keyValue = (element.key as ValueKey).value;
            switch(keyValue){
              case (ElementsType.exponentiationElement):
              {
                return addToTeXData(widgetsData: element.children, parseFunction: expParser);
              }
              case (ElementsType.sqrtElement):
              {
                return addToTeXData(widgetsData: element.children, parseFunction: sqrtParser);
              }
              case (ElementsType.cosElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\cos');
              }
              case (ElementsType.sinElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\sin');
              }
              case (ElementsType.tanElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\tan');
              }
              case (ElementsType.cotElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\cot');
              }
              case (ElementsType.arccosElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\arccos');
              }
              case (ElementsType.arcsinElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\arcsin');
              }
              case (ElementsType.arctanElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\arctan');
              }
              case (ElementsType.arccotElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\arccot');
              }
              case (ElementsType.naturalLogElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\ln'); 
              }
              case (ElementsType.logBaseTwoElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\log_2');
              }
              case (ElementsType.decimalLogElement):
              {
                return addToTeXData(widgetsData: element.children,parseFunctionWithTeXFormula: trigonometricParser,teXFormula: '\\lg');
              }
              case (ElementsType.indefiniteIntegralElement):
              {
                final integralString = undefinitIntegralParser(element.children);
                formulaInTeX = formulaInTeX + integralString;
                return formulaInTeX; 
              }

            }
          } else {
            final intermediateTeXData = formulaInTeX; 
            formulaInTeX =''; 
            _formulaParser(element.children);
            formulaInTeX = intermediateTeXData+formulaInTeX;
            return formulaInTeX;
          }
          break;
        }
      case const (Column):
        {
          element as Column;
          if (element.key != null) {
            final key = element.key as ValueKey;
            if (key.value == ElementsType.fracElement) {
              final fracString = fracParser(element.children);
              formulaInTeX = formulaInTeX + fracString;
              return formulaInTeX;
            }
          }

          break;
        }
        case const (Stack):
          {
            element as Stack;
            if (element.key != null) {
              final key = element.key as ValueKey;
              switch (key.value) {
                case (ElementsType.logElement):
                  {
                    final logString = logParser(element.children);
                    formulaInTeX = formulaInTeX + logString;
                    return formulaInTeX; 
                  }
                case(ElementsType.limitElement):
                {
                  final limitString = limitParser(element.children);
                  formulaInTeX = formulaInTeX + limitString; 
                  return formulaInTeX; 
                }
                case(ElementsType.integralElement):
                {
                  final intString = integralParser(element.children); 
                  formulaInTeX = formulaInTeX + intString;
                  return formulaInTeX;
                }
              }
            } else {
              if (element.children.isNotEmpty) {
                return _formulaParser(element.children);
              }
            }
          
          break;
        }
      case const (SizedBox):
        {
          element as SizedBox;
          if (element.child != null) {
            if (element.key != null && element.key is ValueKey) {
              final key = element.key as ValueKey; 
              final keyValue = key.value; 
              switch (keyValue) 
              {
                case (ElementsType.absElement):
                  {
                    final absString = absParser([element.child!]);
                    formulaInTeX = formulaInTeX + absString; 
                    return formulaInTeX; 
                  }
              }
            }
            return _formulaParser([element.child!]);
          }
          
          
          break;
        }
      case const (Positioned):
        {
          element as Positioned;
          return _formulaParser([element.child]);
          break;
        }
      case const (TextField):
        {
          element as TextField;
          formulaInTeX = formulaInTeX + element.controller!.text;
          return element.controller?.text;
          // break;
        }
      case const (IntegralWidget):
      {
        element as IntegralWidget;
          return _formulaParser([element.child!]);
      }
      case const (IntegralArgumentWidget):
      {
        element as IntegralArgumentWidget;
        return _formulaParser([element.child!]);
      }
    }
  }
  print(formulaInTeX); 
}

String addToTeXData({
      Function(List<Widget>)? parseFunction,required List<Widget> widgetsData,Function(List<Widget>,String)? parseFunctionWithTeXFormula,String? teXFormula}) {
    final intermediateTeXData = formulaInTeX;
    var teXData = ''; 
    if(parseFunction != null){
      teXData = parseFunction(widgetsData) as String;
    }else if(teXFormula != null && parseFunctionWithTeXFormula != null){
      teXData = parseFunctionWithTeXFormula(widgetsData,teXFormula) as String;
    }
    
    formulaInTeX = intermediateTeXData + teXData;
    print(formulaInTeX);
    return formulaInTeX;
  }

String expParser(List<Widget> widgets){
  String teXExpData=''; 
  for(final element in widgets){
    if(element.runtimeType == SizedBox){
      element as SizedBox; 
      if(element.child != null){
        final textData = _formulaParser([element.child!]); 
        teXExpData = '^$textData';
      }
    }else{

    }
  }
  return teXExpData;
}

String sqrtParser(List<Widget> widgets){
  String textData=''; 
  for(final element in widgets){
    if(element.runtimeType == SizedBox){
      element as SizedBox; 
      if(element.child != null){
        final data = _formulaParser([element.child!]); 
        textData = '$textData$data';
      }
    }else if(element.runtimeType == Stack){
      element as Stack; 
      final data = _formulaParser([element]); 
      textData = '$textData$data';
    }
  }
  final teXSqrtData = '\\sqrt{$textData}';
  return teXSqrtData;
}
String fracParser(List<Widget> widgets) {
  final List<String> fracData = ['', ''];
  for (final element in widgets) {
    if (element.runtimeType == SizedBox) {
      element as SizedBox;
      if (element.child != null) {
        final textController = _formulaParser([element.child!]);

        if (fracData.first.isEmpty) {
          fracData.first = textController ?? '';
        } else if (fracData[1].isEmpty) {
          fracData[1] = textController ?? '';
        }
        formulaInTeX = '';
      }
    } else {}
  }
  final fracStringData = '\\frac{${fracData[0]}}{${fracData[1]}}';
  return fracStringData;
}

// String absParser(List<Widget> widgets){
//   final List<String>>
// }

String logParser(List<Widget> widgets) {
    final List<String> logData = ['', ''];
    for (final element in widgets) {
      if (element is Positioned) {
        final fieldData = _formulaParser([element.child]);
        if (logData[0].isEmpty) {
          logData[0] = fieldData ?? '';
        } else if (logData[1].isEmpty) {
          logData[1] = fieldData ?? '';
        }
        formulaInTeX = '';
      }
    }
  final logStringData = '\\log_{${logData[1]}}${logData[0]}';
  return logStringData; 
}

String integralParser(List<Widget> widgets){
  final List<String> integralData = ['','','',''];
  for(final element in widgets){
    if(element.runtimeType == Positioned){
      element as Positioned;  
      final fieldData = _formulaParser([element.child]);
      if(integralData[0].isEmpty){
        integralData[0] = fieldData ??'';
      }
      else if(integralData[1].isEmpty){
        integralData[1] = fieldData ??'';
      }
      else if(integralData[2].isEmpty){
        integralData[2] = fieldData ??'';
      }
      else if(integralData[3].isEmpty){
        integralData[3] = fieldData ??'';
      }
      formulaInTeX = '';
    }
  }
  print("tyt");
  print(formulaInTeX);
  formulaInTeX = ''; 
  final integralString = '\\integral{${integralData[0]}}{${integralData[1]}} ${integralData[2]} d${integralData[3]}';
  return integralString; 
}

String undefinitIntegralParser(List<Widget> widgets){
  final List<String> integralData = ['',''];
  for(final element in widgets){
    if(element.runtimeType == IntegralArgumentWidget){
      final arg = element as IntegralArgumentWidget;
      integralData[0] = _formulaParser([arg.child!]) ??''; 
    }else if(element.runtimeType == SizedBox){
      final sizedBox = element as SizedBox; 
      integralData[1] = _formulaParser([sizedBox.child!]) ??'';
    }
  }
  formulaInTeX = ''; 
  final integral = '\\int ${integralData[0]} d${integralData[1]}'; 
  return integral;
}

String absParser(List<Widget> widgets){
  if(widgets.first is Row){
    final row = widgets.first as Row; 
    final fieldData = _formulaParser(row.children);
    formulaInTeX = ''; 
    return '\\abs{$fieldData}'; 
  }
  return ''; 
}

String limitParser(List<Widget> widgets){
  final List<String> limitData = ['','',''];
  for(final element in widgets){
    if(element is Positioned){
      final fieldData = _formulaParser([element.child]);
      if(limitData[0].isEmpty){
        limitData[0] = fieldData ?? ''; 
      }
      else if(limitData[1].isEmpty){
        limitData[1] = fieldData ?? '';
      }
      else if(limitData[2].isEmpty){
        limitData[2] = fieldData ?? ''; 
      }
      formulaInTeX = ''; 
    }
  }
  final limitStringData = '\\lim_{${limitData[1]}\\to\\${limitData[2]}} ${limitData[0]}';
  return limitStringData; 
}

String trigonometricParser(List<Widget> widgets, String TeXFormula){
  if(widgets[2] is SizedBox && (widgets[2] as SizedBox).child != null)
  {
    final sizedBox = widgets[2] as SizedBox;
    final stringData = _formulaParser([sizedBox.child!]);
    formulaInTeX = ''; 
    return '$TeXFormula $stringData';
  } 
  return ''; 
}

}