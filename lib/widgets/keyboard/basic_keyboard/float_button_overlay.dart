import 'package:flutter/material.dart';
import 'basic_keyboard.dart';

const _floatButtonHeight = 50.0;
const _buttonOffset = 30.0;

class FloatButtonOverlay{
  OverlayEntry? _overlayEntry;
  
  void createOverlay(BuildContext context, { 
    required List<FloatButtonData> buttonsData,
    required double keyboardSpacing,
    required double keyboardPaddings,
    required int floatButtonOverlayDuration,
    required double buttonWidth,
    }) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox; 
    final offset = renderBox.localToGlobal(Offset.zero);
    final List<Widget> buttonsWidgets = [];
    for(int index= 0; index < buttonsData.length; index++){
      buttonsWidgets.add(SizedBox(
        width: buttonWidth,
        height: _floatButtonHeight,
        child: TextButton(
            style: defalultOverlayButtonStyle,
            onPressed: () {
              buttonsData[index].buttonFuction();
              _deleteOverlay(); 
            },
            child: buttonsData[index].buttonWidget),
      ),);
      buttonsWidgets.add(SizedBox(width: keyboardSpacing));
    } 
    late final double offestDx;
    if(offset.dx - (buttonsData.length - 1) * _buttonOffset > 0){
      offestDx = offset.dx - (buttonsData.length - 1) * _buttonOffset;
    } 
    else{ 
      offestDx = keyboardPaddings / 2;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
          left: offestDx,
          top: offset.dy - _floatButtonHeight - keyboardSpacing,
          child: Row(
            children: buttonsWidgets
          )
        )
    );
    overlay.insert(_overlayEntry!); 
    Future.delayed(Duration(seconds: floatButtonOverlayDuration)).then((_)=> _deleteOverlay()); 
  }

  void _deleteOverlay(){
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class FloatButtonData{ 
  final Function buttonFuction; 
  final Widget buttonWidget;
  final ButtonStyle? buttonStyle;

  FloatButtonData({required this.buttonFuction, required this.buttonWidget, this.buttonStyle}); 
}