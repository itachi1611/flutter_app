import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/dialog_type.dart';

class AppFlushBar {
  static void showFlushBar(BuildContext context,
      {DialogType type = DialogType.INFO,
        String title = "",
        String message = "",
        int duration = 3,
        FlushbarPosition position = FlushbarPosition.TOP}) {
    Color _backgroundColor;
    Icon _icon;
    String _title;
    switch (type) {
      case DialogType.INFO:
        _backgroundColor = Color(0xFF2663A0);
        _icon = Icon(Icons.info, color: Colors.white);
        _title = "Info";
        break;
      case DialogType.SUCCESS:
        _backgroundColor = Color(0xFF63a026);
        _icon = Icon(Icons.check_circle, color: Colors.white);
        _title = "Success";
        break;
      case DialogType.ERROR:
        _backgroundColor = Color(0xFFf64438);
        _icon = Icon(Icons.error, color: Colors.white);
        _title = "Error";
        break;
      case DialogType.WARNING:
        _backgroundColor = Color(0xFFedbc38);
        _icon = Icon(Icons.warning, color: Colors.white);
        _title = "Warning";
        break;
    }

    if (title != null && title.isNotEmpty) {
      _title = title;
    }

    Flushbar flushBar;
    flushBar = Flushbar(
      title: _title,
      message: message.isNotEmpty && message != null
          ? message
          : title.isNotEmpty && title != null
          ? title
          : "",
      duration: Duration(seconds: duration),
      flushbarPosition: position,
      backgroundColor: _backgroundColor,
      icon: _icon,
    );
    flushBar.show(context);
  }

  static void showMessageFlushBar(
      BuildContext context, String title, String message) {
    Flushbar flushBar;
    flushBar = Flushbar(
      title: title == ""
          ? ""
          : title,
      message: message != ""
          ? message
          : title == ""
          ? ""
          : title,
      isDismissible: true,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Color(0xFF63a026),
      icon: Icon(Icons.mail_outline, color: Colors.white),
    );
    flushBar.show(context);
  }

  static void showCoordinationFlushBar(
      BuildContext context, String title, String message) {
    Flushbar flushBar;
    flushBar = Flushbar(
      title: title ?? "",
      message: message ?? "",
      isDismissible: true,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Color(0xFF63a026),
      icon: Icon(Icons.mail_outline, color: Colors.white),
    );
    flushBar.show(context);
  }

  static void showPointFlushBar(
      BuildContext context, String title, String message) {
    Flushbar flushBar;
    flushBar = Flushbar(
      title: title ?? "",
      message: message ?? "",
      isDismissible: true,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Color(0xFF63a026),
      icon: Icon(Icons.mail_outline, color: Colors.white),
    );
    flushBar.show(context);
  }
}
