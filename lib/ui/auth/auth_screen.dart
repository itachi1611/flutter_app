import 'package:flutter/material.dart';
import 'package:flutter_app/ui/auth/login/login_screen.dart';
import 'package:flutter_app/utlis/app_images.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image(
                image: AssetImage(
                  AppImages.icLogo
                ),
                width: 200,
                height: 200,
              ),
            ),
            const Divider(
              color: Colors.blueAccent,
              height: 10,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Expanded(
              flex: 1,
              child: _buildSocialAuth(),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(String title) {
    return RaisedButton(
      onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen())),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.grey)
      ),
      highlightElevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialAuth() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(
          left: 0,
          top: 24,
          right: 0,
          bottom: 6
        ),
        width: 300,
        child: Column(
          children: [
            _buildLoginButton('Login'),
            _buildSocialButton(_signInDynamicLink, AppImages.icDynamic, 'Login with Dynamic link'),
            _buildSocialButton(_signInWithGoogle, AppImages.icGoogle,'Sign in with Google'),
            _buildSocialButton(_signInWithGithub, AppImages.icGithub, 'Sign in with Github')
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(VoidCallback onPress, String icon, String title) {
    return RaisedButton(
      onPressed: () => onPress,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.grey)
      ),
      highlightElevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(image: AssetImage(icon), height: 25),
          SizedBox(width: 10,),
          Text(title)
        ],
      ),
    );
  }

  void _signInWithGithub() {

  }

  void _signInWithGoogle() {

  }

  void _signInDynamicLink() {

  }
}
