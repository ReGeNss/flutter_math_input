import 'package:flutter/material.dart';
import '../math_constructions/index.dart';
import '../parsers/formulas_tree_parsers.dart';

class WidgetsDataHandler{
  void replaceWidgetInTree(
    ParsedWidgetsData parsedData, 
    MathConstructionWidgetData mathConstructions,
  ){
    if(mathConstructions.additionalWidget != null){
      parsedData.widgetData?.replaceRange(
        parsedData.index!, parsedData.index!+1,
        [mathConstructions.construction, mathConstructions.additionalWidget!],
      );
    }else{
      parsedData.widgetData?[parsedData.index!] = 
        mathConstructions.construction;
    }
  }
  void addToWidgetTree(ParsedWidgetsData parsedData, List<Widget> widget){
    parsedData.widgetData!.addAll(widget); 
  } 
  void deleteFromWidgetTree(ParsedWidgetsData parsedData){
    parsedData.widgetData?.removeAt(parsedData.index!); 
  }
}
