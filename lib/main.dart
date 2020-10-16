import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/extension/app_theme_data.dart';
import 'package:flutter_app/ui/home_screen.dart';
import 'package:flutter_app/ui/login_screen.dart';
import 'package:flutter_app/ui/widget/center_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    _saveUser(_user);
    print(_user);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData().materialTheme,
      home: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: (_user != null) ? HomeScreen(child: CenterWidget()) : LoginScreen(),
        //title: ,
        image: Image.asset(
          'assets/images/ic_logo.png',
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

  void _saveUser(User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("user", user.toString());
  }
}