import 'dart:ui';

import 'package:flutter/material.dart';

enum RelayedPositionedType {
  fromRight,
  fromLeft,
  fromTop,
  fromBottom,
}

class RelayedPositioned extends StatefulWidget {
  RelayedPositioned({
    super.key,
    required this.widgetToWrap,
    required this.connectedWidgetKeys,
    this.offsetByHeight,
    this.offsetByWidth,
    this.right,
    this.left,
    this.top,
    this.bottom,
    this.divideOffset = false,
  });

  Widget widgetToWrap;
  final bool divideOffset; 
  final List<GlobalKey> connectedWidgetKeys;
  final double? right; 
  final double? left;
  final double? top;
  final double? bottom;
  final RelayedPositionedType? offsetByHeight;
  final RelayedPositionedType? offsetByWidth;
  Widget? wrappedWidget; 

  @override
  State<RelayedPositioned> createState() => _RelayedPositionedState();
}

class _RelayedPositionedState extends State<RelayedPositioned> {
  double? widthOffset; 
  double? heightOffset;

  void getSize(List<FrameTiming> frameTiming) {
    widthOffset = 0;
    heightOffset = 0;
    for (final key in widget.connectedWidgetKeys) {
      if (key.currentContext != null) {
        final renderBox = key.currentContext
            ?.findRenderObject() as RenderBox;
        if (widthOffset == null ||
            widthOffset != renderBox.size.width ||
            heightOffset == null ||
            heightOffset != renderBox.size.height) {
          widthOffset = (widthOffset ?? 0) + renderBox.size.width;
          heightOffset = (heightOffset ?? 0) + renderBox.size.height;
          setState(() {});
        }
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
  }

  @override
  void initState() {
    if(widget.widgetToWrap is! Row){
      widget.widgetToWrap = Row(
        children: [
          widget.widgetToWrap,
        ],
      );
    }
    WidgetsBinding.instance.addTimingsCallback(getSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? topOffset = widget.top;
    double? bottomOffset = widget.bottom;
    double? leftOffset = widget.left;
    double? rightOffset = widget.right;

    if(widget.offsetByHeight != null){
      switch(widget.offsetByHeight!) {
        case RelayedPositionedType.fromBottom:
          if(bottomOffset != null){
            bottomOffset += heightOffset ?? 0;
          }else{
            bottomOffset = heightOffset ?? 0;
          }
          if(widget.divideOffset == true){
            bottomOffset = bottomOffset / 2;
          }
          break;
        case RelayedPositionedType.fromTop:
          if(topOffset != null){
            topOffset += heightOffset ?? 0;
          }else{
            topOffset = heightOffset ?? 0;
          }
          if(widget.divideOffset == true){
            topOffset = topOffset / 2;
          }
          break;
        default:
          break;
      }
    }

    if(widget.offsetByWidth != null){
      switch(widget.offsetByWidth!) {
        case RelayedPositionedType.fromLeft:
          if(leftOffset != null){
            leftOffset += widthOffset ?? 0;
          }else{
            leftOffset = widthOffset ?? 0;
          }
          if(widget.divideOffset == true){
            leftOffset = leftOffset / 2;
          }
          break;
        case RelayedPositionedType.fromRight:
          if(rightOffset != null){
            rightOffset += widthOffset ?? 0;
          }else{
            rightOffset = widthOffset ?? 0;
          }
          if(widget.divideOffset == true){
            rightOffset = rightOffset / 2;
          }
          break;
        default:
          break;
      }
    }
    widthOffset ??= 0;
    widget.wrappedWidget = Positioned(
      top: topOffset,
      left: leftOffset,
      right: rightOffset,
      bottom: bottomOffset,
      child: widget.widgetToWrap,
    );
    return widget.wrappedWidget!;
  }
}
