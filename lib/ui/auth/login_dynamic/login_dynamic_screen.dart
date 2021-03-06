import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginDynamicScreen extends StatefulWidget {
  final url = 'https://static-s.aa-cdn.net/img/ios/1458332586/7bc3cad5b2658f9bfdcdd4a8899c2d0b?v=1';

  @override
  _LoginDynamicScreenState createState() => _LoginDynamicScreenState();
}

class _LoginDynamicScreenState extends State<LoginDynamicScreen> with WidgetsBindingObserver {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Column(
          children: [
            _buildLogo(),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEmailField(),
                  _buildLoginBtn(),
                ],
              ),
            ),
          ],
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
            validator: (value) => _validateEmail(value),
            //onSaved: (value) => _saveEmail(value),
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
                'Sign In'
            ),
          ),
        )
    );
  }

  String _validateEmail(String email) {
    if(email.isEmpty) {
      return 'Please enter email';
    }

    Pattern pattern = r'^([a-zA-Z0-9_.]{1,32}@[a-zA-Z0-9-_,.]{2,}(\.[a-zA-Z0-9-_,.]{2,})+)$';
    RegExp regex = new RegExp(pattern);
    if(!regex.hasMatch(email)) {
      return 'Email not right format';
    }
    return null;
  }

  Future<void> _onLogin() async {
    if(_formKey.currentState.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        }
      );

      await _auth.sendSignInLinkToEmail(
          email: _emailController.text,
          actionCodeSettings: ActionCodeSettings(
            url: 'https://flutterapp1.page.link',
            handleCodeInApp: true,
            iOSBundleId: 'com.fox.flutter_app',
            androidPackageName: 'com.fox.flutter_app',
            androidInstallApp: true,
            androidMinimumVersion: '1'
          )
      );
    } else {
      print('Can not validate user information');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}