import 'package:flutter/material.dart';
import 'package:flutter_app/ui/custom/custom_inherited_widget.dart';

class CenterTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = CustomInheritedWidget.of(context).data;
    return Text(
      'Current counter value : $_counter'
    );
  }
}
