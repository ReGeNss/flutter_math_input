import 'package:flutter/material.dart';
import '../interfaces/index.dart';

extension ChildExtension on Widget{
  bool get isSingleChild{
    if(
      this is SingleChildRenderObjectWidget || 
      this is SingleChildConstruction || 
      this is ParentDataWidget
    ){
      return true; 
    }
    return false;
  }

  bool get isMultiChild{
    if(this is MultiChildRenderObjectWidget || this is MultiChildConstruction){
      return true;
    } 

    return false;
  }

  Widget? get singleChild{
    if(this is SingleChildRenderObjectWidget){
      return (this as SingleChildRenderObjectWidget).child;
    }
    if(this is SingleChildConstruction){
      return (this as SingleChildConstruction).child;
    }
    if(this is ParentDataWidget){
      return (this as ParentDataWidget).child;
    }

    return null;
  }

  List<Widget> get multiChild{
    if(this is MultiChildRenderObjectWidget){
      return (this as MultiChildRenderObjectWidget).children;
    }
    if(this is MultiChildConstruction){
      return (this as MultiChildConstruction).children;
    }
    return [];
  }
}