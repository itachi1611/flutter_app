import 'package:flutter/material.dart';
import 'package:flutter_app/ui/custom/custom_inherited_widget.dart';

class DateTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _date = CustomInheritedWidget.of(context).date;
    return Text(
        'You selected  $_date'
    );
  }
}
