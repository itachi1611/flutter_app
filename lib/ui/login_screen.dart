import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/extension/app_flush_bar.dart';
import 'package:flutter_app/model/dialog_type.dart';
import 'package:flutter_app/ui/home/home_screen.dart';
import 'package:flutter_app/ui/login_dynamic_screen.dart';
import 'package:flutter_app/ui/register_screen.dart';
import 'package:flutter_app/ui/verify_screen.dart';
import 'package:flutter_app/ui/widget/center_widget.dart';
import 'package:flutter_app/utlis/field_validator.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginScreen extends StatefulWidget {
  final url = 'https://static-s.aa-cdn.net/img/ios/1458332586/7bc3cad5b2658f9bfdcdd4a8899c2d0b?v=1';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _togglePass;

  @override
  void initState() {
    _togglePass = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Login'
        ),
      ),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
            maintainBottomViewPadding: true,
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildLogo(),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEmailField(),
                          _buildPassField(),
                          _buildLoginBtn(),
                          const Divider(
                            color: Colors.black,
                            height: 10,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          _buildSocialAuth(),
                          _buildRegisterRow(context)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return CachedNetworkImage(
      imageUrl: widget.url,
      width: 150,
      height: 150,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget _buildEmailField() {
    return Container(
      padding: EdgeInsets.only(
          left: 32,
          top: 8,
          right: 32,
          bottom: 8
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyle(
                color: Colors.pink[800],
                fontSize: 15,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _emailController,
            obscureText: false,
            cursorColor: Colors.pink[300],
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            showCursor: true,
            decoration: InputDecoration(
              hintText: 'Enter email',
              prefixIcon: Icon(
                  Icons.email
              ),
              suffixIcon: IconButton(
                icon: Icon(
                    Icons.clear
                ),
                tooltip: 'Clear email',
                onPressed: () => _emailController.clear(),
              ),
            ),
            validator: (value) => FieldValidator.validateEmail(value),
            //onSaved: (value) => _saveEmail(value),
          ),
        ],
      ),
    );
  }

  Widget _buildPassField() {
    return Container(
      padding: EdgeInsets.only(
          left: 32,
          top: 16,
          right: 32,
          bottom: 16
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: TextStyle(
                color: Colors.pink[800],
                fontSize: 15,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none
            ),
          ),
          TextFormField(
            obscureText: _togglePass,
            controller: _passController,
            textInputAction: TextInputAction.done,
            showCursor: true,
            cursorColor: Colors.pink[300],
            keyboardType: TextInputType.visiblePassword,
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
                hintText: 'Enter password',
                prefixIcon: Icon(
                    Icons.lock
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _togglePass ? Icons.visibility : Icons.visibility_off,
                  ),
                  padding: EdgeInsets.all(0),
                  tooltip: _togglePass ? 'Show password' : 'Hide password',
                  onPressed: () {
                    setState(() {
                      _togglePass = !_togglePass;
                    });
                  },
                )
            ),
            validator: (value) => FieldValidator.validatePass(value),
            //onSaved: (value) => _savePass(value),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Padding(
        padding: const EdgeInsets.only(
            left: 0,
            top: 24,
            right: 0,
            bottom: 6
        ),
        child: Center(
          child: RaisedButton(
            onPressed: () => _onLogin(),
            child: Text(
              'Sign In'.toUpperCase()
            ),
          ),
        )
    );
  }

  Widget _buildSocialAuth() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
        top: 24,
        right: 0,
        bottom: 6
      ),
      child: Center(
        child: Container(
          width: 300,
          child: Column(
            children: [
              RaisedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginDynamicScreen())),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(color: Colors.grey)
                  ),
                  highlightElevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.phone_android),
                      SizedBox(width: 10),
                      Text('Login with Dynamic link'),
                    ],
                  )
              ),
              RaisedButton(
                onPressed: () {
                  _loginWithGoogle().then((res) {
                    if (res != null) {
                      Future.delayed(const Duration(seconds: 5), () {
                        AppFlushBar.showFlushBar(context, type: DialogType
                            .SUCCESS, message: 'Login success');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(child: CenterWidget())));
                      });
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: BorderSide(color: Colors.grey)
                ),
                highlightElevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image(image: AssetImage('assets/images/google_logo.png'), height: 25,),
                    SizedBox(width: 10,),
                    Text('Sign in with Google')
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _signInWithGithub().then((res) {
                    if(res != null) {
                      Future.delayed(const Duration(seconds: 5), () {
                        AppFlushBar.showFlushBar(context, type: DialogType
                            .SUCCESS, message: 'Login success');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(child: CenterWidget())));
                      });
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: BorderSide(color: Colors.grey)
                ),
                highlightElevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image(image: AssetImage('assets/images/github_logo.png'), height: 25),
                    SizedBox(width: 10,),
                    Text('Sign in with Github')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen())),
            child: Text(
              'Don\'t have an account ?',
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.w500,
                fontSize: 12
              ),
            ),
          ),
          GestureDetector(
            onTap: () {

            },
            child: Text(
              'Forgot your password ?',
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.w500,
                fontSize: 12
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _loginWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;


    if(user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('loginWithGoogle succeeded : $user');
      return '$user';
    }
    return null;
  }

  Future<String> _signInWithGithub() async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: 'af1a1c6c537745490053',
      clientSecret: '302a57b6fcec32777d6f274462e912dd2fc3d914',
      redirectUrl: 'https://fox-flutter.firebaseapp.com/__/auth/handler'
    );
    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);
    // Create a credential from the access token
    final AuthCredential authCredential = GithubAuthProvider.credential(result.token);
    // Once signed in, return the UserCredential
    final UserCredential authResult = await _auth.signInWithCredential(authCredential);
    final User user = authResult.user;

    if(user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      print('loginWithGithub : $user');
      return '$user';
    }
    return null;
  }

  void _signOutGoogle() async {
    await googleSignIn.signOut();
    print('User signed out');
  }

  void _onLogin() async {
    if(_formKey.currentState.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          }
      );

      try {
        await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passController.text).then((res) {
          if(res != null) {
            Navigator.pop(context);
            _saveUserAfterSignIn(res.user);
            if(!res.user.emailVerified) {
              res.user.sendEmailVerification();
              Future.delayed(const Duration(seconds : 5), () {
                AppFlushBar.showFlushBar(context, type: DialogType.INFO, message: 'PThe verification code has been sent to ${res.user.email}');

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => VerifyScreen()
                    )
                ).then((_) {
                  _formKey.currentState?.reset();
                });
              });
            } else {
              Future.delayed(const Duration(seconds : 5), () {
                AppFlushBar.showFlushBar(context, type: DialogType.SUCCESS, message: 'Login success');
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(child: CenterWidget())
                    )
                ).then((_) {
                  _formKey.currentState?.reset();
                });
              });
            }

          }
        }, onError: (err) {
          Navigator.pop(context);
          print(err);
          AppFlushBar.showFlushBar(context, type: DialogType.ERROR, message: err.toString());
        });
      } on FirebaseAuthException catch(e) {
        if(e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if(e.code == 'wrong-password') {
          print('Wrong password provided for that user');
        }
      } catch(e) {
        print(e);
      }

      //_formKey.currentState.save();

      // _scaffoldKey.currentState.showSnackBar(
      //   SnackBar(
      //     content: Text('Email : ${_user.email} and Password: ${_user.pass}'),
      //     duration: Duration(seconds: 3),
      //     behavior: SnackBarBehavior.floating,
      //     elevation: 10,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(15),
      //       side: BorderSide(
      //           color: Colors.yellow,
      //           width: 1.5
      //       ),
      //     ),
      //     onVisible: () => print('Snackbar is shown'),
      //     action: SnackBarAction(
      //       label: 'Dismiss',
      //       textColor: Colors.yellow[600],
      //       disabledTextColor: Colors.blue[500],
      //       onPressed: () => _scaffoldKey.currentState.removeCurrentSnackBar(),
      //     ),
      //   ),
      // );
    } else {
      print('Can not validate user information');
    }
    //Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  void _saveUserAfterSignIn(User user) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String _currentUser = _preferences.getString('user') ?? "";
    if(_currentUser.isNotEmpty && _currentUser != null) {
      _preferences.remove('user');
      _preferences.setString('user', user.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
