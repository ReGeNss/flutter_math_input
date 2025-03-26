import 'dart:ui';
import 'package:flutter/widgets.dart';
import '../../services/math_constructions_building.dart';

class WidgetDynamicSizeWrapper extends StatefulWidget implements SingleChildConstruction{
  WidgetDynamicSizeWrapper({
    super.key,
    required this.connectedKeysToWidth,
    required this.child, 
    required this.connectedKeysToHeight,
    this.defaultWidth, 
    this.defaultHeight,
  });

  final List<GlobalKey> connectedKeysToWidth;
  final List<GlobalKey> connectedKeysToHeight;
  final double? defaultWidth;
  final double? defaultHeight; 
  @override
  Widget? child; 

  @override
  State<WidgetDynamicSizeWrapper> createState() => _WidgetDynamicSizeWrapperState();
}

class _WidgetDynamicSizeWrapperState extends State<WidgetDynamicSizeWrapper> {
  double width = 0; 
  double height = 0;

  void getSize(List<FrameTiming> timings) {
    height = 0; 
    width = 0;
    for(final key in widget.connectedKeysToWidth) { 
      if(key.currentContext != null){
        final renderBox = key.currentContext?.findRenderObject() as RenderBox;
        if(width != renderBox.size.width || height != renderBox.size.height){
          width += renderBox.size.width;
          if(height < renderBox.size.height){
            height = renderBox.size.height;
          }
        }
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addTimingsCallback(getSize);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.defaultHeight,
      width: width + (widget.defaultWidth ?? 0),
      child: widget.child,
    );
  }
}