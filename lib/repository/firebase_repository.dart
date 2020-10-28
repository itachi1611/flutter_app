import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_app/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

///Thrown if during the sign up process if a failure occurs
class SignUpFailure implements Exception {}

///Thrown during the login process if a failure occurs
class LogInWithEmailAndPasswordFailure implements Exception {}

///Thrown during the sign in with google process if a failure occurs
class LogInWithGoogleFailure implements Exception {}

///Thrown during the logout process if a failure occurs
class LogOutFailure implements Exception {}

class FirebaseRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty : firebaseUser.toUser;
    });
  }

  Future<void> signInWithCredentials({@required String e, @required String p}) async {
    assert(e != null && p != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: e, password: p);
    } on firebase_auth.FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
      }
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    } catch(e) {
      print(e);
    }
  }

  Future<void> signUpWithCredentials(String e, String p) async {
    assert(e != null && p != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: e, password: p);
    } on firebase_auth.FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } on Exception {
      throw SignUpFailure();
    } catch(e) {
      print(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch(e) {
      if(e.code == 'user-not-found') {
        print('No user found for that emails');
      } else if(e.code == 'wrong-password') {
        print('Wrong password provided for that user');
      }
    } on Exception {
      throw LogInWithGoogleFailure();
    } catch(e) {
      print(e);
    }
  }

  Future<void> signOutApp() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut()
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }

  Future<bool> isSignedIn() async {
    final _currentUser = await getCurrentUser();
    return _currentUser != null;
  }

  Future<firebase_auth.User> getCurrentUser() async {
    var user = _firebaseAuth.currentUser;
    return user;
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}