import 'package:flutter/material.dart';

class SliderRightRoute extends PageRouteBuilder {
  final Widget widget;

  SliderRightRoute({
    this.widget
  }) : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      //SlideTransition can be replaced with another transition widgets provided such as ScaleTransition or FadeTransition
      return new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero
        ).animate(animation),
        child: child,
      );
    }
  );

}