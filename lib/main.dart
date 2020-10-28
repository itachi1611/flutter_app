import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/extension/app_theme_data.dart';
import 'package:flutter_app/helper/shared_preference_helper.dart';
import 'package:flutter_app/ui/auth/auth_screen.dart';
import 'package:flutter_app/ui/home/home_screen.dart';
import 'package:flutter_app/ui/widget/center_widget.dart';
import 'package:flutter_app/utlis/app_images.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;

    if(_user != null) {
      SharedPreferenceHelper.setAccount(_user);
    }

    print(_user);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData().materialTheme,
      home: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: (_user != null) ? HomeScreen(child: CenterWidget()) : AuthScreen(),
        //title: ,
        image: Image.asset(
          AppImages.icLogo,
          width: 150,
          height: 150,
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 150,
        //onClick: ,
        loaderColor: Colors.pink[500],
      ),
    );
  }
}