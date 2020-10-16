import 'package:flutter/material.dart';

class ScaleRouter extends PageRouteBuilder {
  final Widget widget;

  ScaleRouter({
    this.widget
  }) : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return ScaleTransition(
        scale: new Tween<double>(
          begin: 0,
          end: 1
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(
              0,
              0.5,
              curve: Curves.linear
            ),
          ),
        ),
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 1.5,
            end: 1,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.5,
                1,
                curve: Curves.linear
              ),
            ),
          ),
          child: child,
        ),
      );
    }
  );
}