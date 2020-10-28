import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  ///Define key
  static final String _tokenPrefs = "token";
  static final String _userPrefs = "user";


  ///Token
  static Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_tokenPrefs, token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(_tokenPrefs);
    if (token == null) {
      return "";
    } else {
      print("Token: " + token);
      return token;
    }
  }

  /// Method that saves the user Account
  static Future<bool> setAccount(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user == null) {
      return false;
    }
    prefs.setString(_userPrefs, user.toString());
    return true;
  }
}