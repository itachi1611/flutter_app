import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widget/center_text_widget.dart';
import 'package:flutter_app/ui/widget/date_time_widget.dart';

class CenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DateTimeWidget(),
          CenterTextWidget()
        ],
      ),
    );
  }
}
