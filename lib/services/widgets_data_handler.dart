import 'package:flutter/material.dart';
import 'package:math_keyboard/parsers/formulas_tree_parsers.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';

class WidgetsDataHandler{
  void replaceWidgetInTree(ParsedWidgetsData parsedData, MathConstructionData mathConstructions){
    if(mathConstructions.addictionalWidget != null){
      parsedData.wigetData?.replaceRange(parsedData.index!, parsedData.index!+1,[mathConstructions.construction, mathConstructions.addictionalWidget!]);
    }else{
      parsedData.wigetData?[parsedData.index!] = mathConstructions.construction;
    }
  }
  void addToWidgetTree(ParsedWidgetsData parsedData, List<Widget> widget){
    parsedData.wigetData!.addAll(widget); 
  }
  void deleteFromWidgetTree(ParsedWidgetsData parsedData){
    parsedData.wigetData?.removeAt(parsedData.index!); 
  }
}