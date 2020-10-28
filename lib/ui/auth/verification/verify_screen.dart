import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  final url = 'https://static-s.aa-cdn.net/img/ios/1458332586/7bc3cad5b2658f9bfdcdd4a8899c2d0b?v=1';

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> with WidgetsBindingObserver {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _codeController = TextEditingController();

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
            controller: _codeController,
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
                onPressed: () => _codeController.clear(),
              ),
            ),
            //validator: (value) => {},
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
            onPressed: () => _onActiveEmail(),
            child: Text(
                'Sign In'
            ),
          ),
        )
    );
  }

  void _onActiveEmail() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String _code = _codeController.text.toString().trim();
    try{
      await _auth.checkActionCode(_code);
      await _auth.applyActionCode(_code);

      //Reload the user if success
      _auth.currentUser.reload();
    } on FirebaseAuthException catch (e) {
      if(e.code == 'invalid-action-code') {
        print('The code is invalid.');
      }
    }

  }
}
