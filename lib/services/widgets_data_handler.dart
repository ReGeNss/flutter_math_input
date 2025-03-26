import 'package:flutter/material.dart';
import '../math_constructions/index.dart';
import '../parsers/formulas_tree_parsers.dart';

class WidgetsDataHandler{
  void replaceWidgetInTree(ParsedWidgetsData parsedData, MathConstructionWidgetData mathConstructions){
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