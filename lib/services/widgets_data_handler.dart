import 'package:flutter/material.dart';
import 'package:math_keyboard/services/formulas_tree_parsers_and_handler.dart';

class WidgetsDataHandler{
  void replaceWidgetInTree(ReturnData parsedData,Widget replaceWidget){
    parsedData.wigetData?[parsedData.index!] = replaceWidget;
  }
}