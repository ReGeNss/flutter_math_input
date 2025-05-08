import 'package:flutter/material.dart';
import '../interfaces/index.dart';

class WidgetsDataHandler{
  WidgetsDataHandler._();
  
  static void replaceWidgetInTree(
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

  static void addToWidgetTree(ParsedWidgetsData parsedData, List<Widget> widget){
    parsedData.widgetData!.addAll(widget); 
  }

  static void deleteFromWidgetTree(ParsedWidgetsData parsedData){
    parsedData.widgetData?.removeAt(parsedData.index!); 
  }
}
