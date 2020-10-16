import 'package:flutter/material.dart';

class CustomInheritedWidget extends InheritedWidget {
  final int data;
  final String date;

  CustomInheritedWidget({
    Widget widget,
    this.data,
    this.date
  }) : super(child : widget);

  @override
  bool updateShouldNotify(CustomInheritedWidget oldWidget) {
    return data != oldWidget.data || date != oldWidget.date;
  }

  static CustomInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomInheritedWidget>();
  }

}