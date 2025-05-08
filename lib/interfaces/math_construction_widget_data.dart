import 'package:flutter/material.dart';

class MathConstructionWidgetData {
  final Widget? additionalWidget;
  final Widget construction;

  MathConstructionWidgetData({
    required this.construction, 
    this.additionalWidget,
  });
}
