import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keyboard_controller.dart';
import 'keyboard/keyboard.dart';

class MathInput extends StatefulWidget {
  const MathInput({
    super.key,
    required this.keyboard,
    this.decoration,
    this.width = double.infinity,
    this.height = 150,
    this.padding = const EdgeInsets.all(10),
  });
  final MathKeyboard keyboard;
  final BoxDecoration? decoration;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;

  @override
  State<MathInput> createState() => _MathInputState();
}

class _MathInputState extends State<MathInput> {
  final GlobalKey _formulasRowKey = GlobalKey();
  late final MathController keyboardController;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final keyboardController = context.read<MathController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final RenderBox? renderBox = _formulasRowKey.currentContext?.findRenderObject() as RenderBox?;
      if(renderBox != null && keyboardController.isFormulaRendred == false){
        keyboardController.changeFormulaRenderingState();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
  try{
    final model = context.watch<MathController>();
    final formula = model.isFormulaUpdated == true
        ? Row(
            key: _formulasRowKey,
            children: model.getFormulaWidgets(),
          )
        : const Center(child: Text('LOAD'));
    return GestureDetector(
      onTap: () => widget.keyboard.show(),
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: widget.decoration ?? BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: formula,
            ),
          ),
        ),
      ),
    );
    } on ProviderNotFoundException {
      throw Exception('MathKeyboardModel not found. Please add provide MathKeyboardModel to your widget tree.');
    } catch (e) {
      return const Center(child: Text('Something went wrong. Tap delete button to clear the input'));
    }
  }
}
