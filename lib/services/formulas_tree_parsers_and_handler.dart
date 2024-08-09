import 'package:flutter/material.dart';

class FormulasTreeParsersService {
  ReturnData? parsedData; 

  ReturnData? parseWidgetList(
      List<Widget> array, TextEditingController activeTextFieldController) {
        textControllerArrayParser(array,activeTextFieldController);
        return parsedData; 
      }

  ReturnData? textControllerArrayParser(List<Widget> array,
      TextEditingController activeTextFieldController
      ) {
    // подумай чи точно тут потрібно перевіряти на колонку і
    final length = array.length;
    ReturnData? data;
    for (int index = 0; length > index; index += 1) {
      switch (array[index].runtimeType) {
        case const (Row):
          {
            final row = array[index] as Row;
            data = textControllerArrayParser(
                row.children, activeTextFieldController, 
                );
            if (data != null) {
              return data;
            }
            break;
          }
        case const (Column):
          {
            final list = array[index] as Column;
            data = textControllerArrayParser(
                list.children, activeTextFieldController, 
                );
            if (data != null) {
              return data;
            }
            break;
          }
        case const (TextField):
          {
            final textFieldWidget = array[index] as TextField;
            if (textFieldWidget.controller == activeTextFieldController) {
              return ReturnData(
                  wigetData: array, index: index, widget: textFieldWidget);
            }
            break;
          }
        case const (SizedBox):
          {
            final widget = array[index] as SizedBox;
            if (widget.child != null) {
              // print('ТУТА $globalKey');
              data = textControllerWidgetParser(
                  widget.child!, activeTextFieldController,
                  );
            }
            if (data != null) {
              
              data.index = index; // костилі
              data.wigetData = array;
              if (parsedData == null) {
                parsedData = data;
                // return data;
              }
            }
            break;
          }
        case const (Stack):
          {
            final list = array[index] as Stack;
            data = textControllerArrayParser(
                list.children, activeTextFieldController,
                );
            if (data != null) {
              // return data;
            }
            break;
          }
        case const (Positioned):
          {
            final widget = array[index] as Positioned;
            data = textControllerWidgetParser(
                widget.child, activeTextFieldController);
            if (data != null) {
              data.index = index; // костилі
              data.wigetData = array;
              if (parsedData == null) {
                parsedData = data;
                return data;
              }
            }
            break;
          }
        // case const (ExpRowWidget) :
        // {
        //   final widget = array[index] as ExpRowWidget;
        //     if(widget.child != null){
        //       data = textControllerWidgetParser(widget.child!, activeTextFieldController, context,globalKey: globalKey);
        //     }
        //     if (data != null) {
        //       data.index = index; // костилі
        //       data.wigetData = array;
        //       if (context.read<KeyboardModel>().parsedData == null) {
        //         // context.read<KeyboardModel>().parsedData = data;
        //         return data;
        //       }
        //     }
        //   break;
        // }
      }
    }
    // return parsedData;
  }
  ReturnData? textControllerWidgetParser(Widget widget, TextEditingController activeTextFieldController){
    ReturnData? data; 
    final widgetRunType = widget.runtimeType;
    switch (widgetRunType) {
      case const (TextField):
      {
        final textFieldWidget = widget as TextField;
        if (textFieldWidget.controller == activeTextFieldController) {
          return ReturnData(widget: textFieldWidget);
        }
        break;
      }
      case const (Column):
      {
          final column = widget as Column;
          data = textControllerArrayParser(
              column.children, activeTextFieldController);
          return data;
      }
      case const (Row):
        {
          final row = widget as Row;
          data = textControllerArrayParser(
              row.children, activeTextFieldController);
          return data;
        }
      case const (Positioned):
      {
        final positioned = widget as Positioned;
      data = textControllerWidgetParser(
          positioned.child, activeTextFieldController, );
      return data;
      }
      case const (SizedBox):
      {
        final sizedBox = widget as SizedBox;
      data = textControllerWidgetParser(
          sizedBox.child!, activeTextFieldController, );
      return data;
      }
      case const (Stack):
      {
        final stack = widget as Stack;
      data = textControllerArrayParser(
          stack.children, activeTextFieldController);
      return data;
      }
    }
    return null;
  }

  // ReturnData? textControllerWidgetParser(Widget widget,
  //     TextEditingController activeTextFieldController, BuildContext context,
  //     {GlobalKey? globalKey = null}) {
  //   ReturnData? data;
  //   final widgetRunType = widget.runtimeType;
    // if (widgetRunType == TextField) {
    //   final textFieldWidget = widget as TextField;
    //   if (textFieldWidget.controller == activeTextFieldController) {
    //     return ReturnData(widget: textFieldWidget, globalKey: globalKey);
    //   }
    // } else if (widgetRunType == Column) {
    //   final column = widget as Column;
    //   data = textControllerArrayParser(
    //       column.children, activeTextFieldController, context,
    //       globalKey: globalKey);
    //   return data;
    // } else if (widgetRunType == Row) {
    //   final row = widget as Row;
    //   if (row.key != null &&
    //       row.key.runtimeType == LabeledGlobalKey<State<StatefulWidget>>) {
    //     final key = row.key as GlobalKey<State<StatefulWidget>>;
    //     globalKey = key;
    //   }
      // data = textControllerArrayParser(
      //     row.children, activeTextFieldController, context,
      //     globalKey: globalKey);
      // return data;
    // } else if (widgetRunType == Positioned) {
    //   final positioned = widget as Positioned;
    //   data = textControllerWidgetParser(
    //       positioned.child, activeTextFieldController, context,
    //       globalKey: globalKey);
    //   return data;
    // } else if (widgetRunType == SizedBox) {
    //   final sizedBox = widget as SizedBox;
    //   data = textControllerWidgetParser(
    //       sizedBox.child!, activeTextFieldController, context,
    //       globalKey: globalKey);
    //   return data;
    // } else if (widgetRunType == Stack) {
    //   final stack = widget as Stack;
    //   data = textControllerArrayParser(
    //       stack.children, activeTextFieldController, context,
    //       globalKey: globalKey);
    //   return data;
    // }
  // }
// }


}
class ReturnData {
  List<Widget>? wigetData;
  int? index;
  Widget? widget;
  GlobalKey? globalKey;
  ReturnData({this.wigetData, this.index, this.widget, this.globalKey});
}