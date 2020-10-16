import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/extension/app_flush_bar.dart';
import 'package:flutter_app/model/dialog_type.dart';
import 'package:flutter_app/ui/login_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterScreen extends StatefulWidget {
  final url = 'https://static-s.aa-cdn.net/img/ios/1458332586/7bc3cad5b2658f9bfdcdd4a8899c2d0b?v=1';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _togglePass;
  bool _toggleConfirmPass;

  @override
  void initState() {
    _togglePass = true;
    _toggleConfirmPass = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode _focusScope = FocusScope.of(context);
        if(!_focusScope.hasPrimaryFocus) {
          _focusScope.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Login'),
        ),
        key: _scaffoldKey,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            child: Column(
              children: [
                _buildLogo(),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildEmailField(),
                      _buildPassField(),
                      _buildConfirmPassField(),
                      _buildLoginBtn(context),
                      _buildRegisterRow()
                    ],
                  ),
                ),
              ],
            )
          ),
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
      padding: EdgeInsets.only(left: 32, top: 8, right: 32, bottom: 8),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        controller: _emailController,
        obscureText: false,
        cursorColor: Colors.pink[300],
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        showCursor: true,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
            color: Colors.pink[800],
            fontSize: 15,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none
          ),
          hintText: 'Enter email',
          prefixIcon: Icon(Icons.email),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            tooltip: 'Clear email',
            onPressed: () => _emailController.clear(),
          ),
        ),
        validator: (value) => _validateEmail(value),
        //onSaved: (value) => _saveEmail(value),
      ),
    );
  }

  Widget _buildPassField() {
    return Container(
      padding: EdgeInsets.only(left: 32, top: 16, right: 32, bottom: 16),
      child: TextFormField(
        obscureText: _togglePass,
        controller: _passController,
        textInputAction: TextInputAction.done,
        showCursor: true,
        cursorColor: Colors.pink[300],
        keyboardType: TextInputType.visiblePassword,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
              color: Colors.pink[800],
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none
          ),
          hintText: 'Enter password',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              _togglePass ? Icons.remove_red_eye : Icons.remove_red_eye,
              color: _togglePass ? null : Colors.blueGrey,
            ),
            padding: EdgeInsets.all(0),
            tooltip: _togglePass ? 'Show password' : 'Hide password',
            onPressed: () {
              setState(() {
                _togglePass = !_togglePass;
              });
            },
          )),
        validator: (value) => _validatePass(value),
        //onSaved: (value) => _savePass(value),
      ),
    );
  }

  Widget _buildConfirmPassField() {
    return Container(
      padding: EdgeInsets.only(left: 32, top: 16, right: 32, bottom: 16),
      child: TextFormField(
        obscureText: _toggleConfirmPass,
        controller: _confirmPassController,
        textInputAction: TextInputAction.done,
        showCursor: true,
        cursorColor: Colors.pink[300],
        keyboardType: TextInputType.visiblePassword,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          labelText: 'Confirm password',
          labelStyle: TextStyle(
              color: Colors.pink[800],
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none
          ),
          hintText: 'Enter password again',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              _toggleConfirmPass ? Icons.remove_red_eye : Icons.remove_red_eye,
              color: _toggleConfirmPass ? null : Colors.blueGrey,
            ),
            padding: EdgeInsets.all(0),
            tooltip: _toggleConfirmPass ? 'Show password' : 'Hide password',
            onPressed: () {
              setState(() {
                _toggleConfirmPass = !_toggleConfirmPass;
              });
            },
          )),
        validator: (value) => _validateConfirmPass(value, _passController.text),
        //onSaved: (value) => _savePass(value),
      ),
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 0, top: 24, right: 0, bottom: 6),
        child: Center(
          child: RaisedButton(
            onPressed: () => _onRegister(),
            child: Text('Sign Up'),
          ),
        ));
  }

  Widget _buildRegisterRow() {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              'Already have an account ?',
              style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Forgot your password ?',
              style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  String _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Please enter email';
    }

    Pattern pattern =
        r'^([a-zA-Z0-9_.]{1,32}@[a-zA-Z0-9-_,.]{2,}(\.[a-zA-Z0-9-_,.]{2,})+)$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return 'Email not right format';
    }
    return null;
  }

  String _validatePass(String pass) {
    if (pass.isEmpty) {
      return 'Please enter password';
    }
    if (pass.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String _validateConfirmPass(String s1, String s2) {
    if (s2.isEmpty) {
      return 'Please enter password';
    }
    if(s2 != s1) {
      return 'Password not match';
    }
    return null;
  }

  void _onRegister() async {
    if (_formKey.currentState.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        }
      );

      await _auth.createUserWithEmailAndPassword(email: _emailController.text.toString().trim(), password: _passController.text.toString().trim()).then((res){
        if(res != null) {
          Navigator.pop(context);
          Future.delayed(const Duration(seconds: 5), () {
            AppFlushBar.showFlushBar(context, type: DialogType.SUCCESS, message: 'Register success');
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()))
                .then((_) {
              _formKey.currentState?.reset();
            });
          });

        }
      }, onError: (err) {
        Navigator.pop(context);
        print(err);
        AppFlushBar.showFlushBar(context, type: DialogType.ERROR, message: err.toString());
      });


    } else {
      print('Can not validate user information');
    }
    //Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }
}
