class FieldValidator {
  static String validateEmail(String email) {
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

  static String validatePass(String pass) {
    if(pass.isEmpty) {
      return 'Please enter password';
    }
    if(pass.length < 5 || pass.length > 10) {
      return 'Password must be 5 to 10 characters';
    }
    return null;
  }
}