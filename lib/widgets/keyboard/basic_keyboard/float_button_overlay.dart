import 'package:flutter/material.dart';
import 'basis_keyboard.dart';

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
            style: defaultOverlayButtonStyle,
            onPressed: () {
              buttonsData[index].buttonFunction();
              _deleteOverlay(); 
            },
            child: buttonsData[index].buttonWidget,),
      ),);
      buttonsWidgets.add(SizedBox(width: keyboardSpacing));
    } 
    double offsetDx;
    if(offset.dx - (buttonsData.length - 1) * _buttonOffset > 0){
      offsetDx = offset.dx - (buttonsData.length - 1) * _buttonOffset;
    } 
    else{ 
      offsetDx = keyboardPaddings / 2;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
          left: offsetDx,
          top: offset.dy - _floatButtonHeight - keyboardSpacing,
          child: Row(
            children: buttonsWidgets,
          ),
        ),
    );
    overlay.insert(_overlayEntry!); 
    Future.delayed(
      Duration(seconds: floatButtonOverlayDuration),
      ).then((_)=> _deleteOverlay(),
    ); 
  }

  void _deleteOverlay(){
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class FloatButtonData{ 
  final Function() buttonFunction; 
  final Widget buttonWidget;
  final ButtonStyle? buttonStyle;

  FloatButtonData({
    required this.buttonFunction, 
    required this.buttonWidget, 
    this.buttonStyle,
  }); 
}
