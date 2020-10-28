import 'package:flutter/material.dart';

class AppImages {
  AppImages._();

  //Commons
  static const icLogo = "assets/images/ic_logo.png";
  static const icGoogle = "assets/images/ic_google.png";
  static const icGithub = "assets/images/ic_github.png";
  static const icDynamic = "assets/images/ic_dynamic_link.png";

  static Image image(String key) {
    return Image.asset(key);
  }
}