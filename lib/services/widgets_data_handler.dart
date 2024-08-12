import 'package:flutter/material.dart';
import 'package:math_keyboard/services/formulas_tree_parsers_and_handler.dart';

class WidgetsDataHandler{
  void replaceWidgetInTree(ReturnData parsedData,Widget replaceWidget){
    parsedData.wigetData?[parsedData.index!] = replaceWidget;
  }
  void addToWidgetTree(ReturnData parsedData, List<Widget> widget){
    parsedData.wigetData!.addAll(widget); 
  }
  void deleteFromWidgetTree(ReturnData parsedData){
    parsedData.wigetData?.removeAt(parsedData.index!); 
  }
}