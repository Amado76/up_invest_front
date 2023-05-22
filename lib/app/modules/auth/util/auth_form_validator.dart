class AuthFormValidator {
  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(_validEmailRegExp).hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? signInPasswordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password.';
    }
    if (password.length < 6) {
      return 'Your password have less than 6 characters!';
    }

    return null;
  }

  String? signUpPasswordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password.';
    }
    if (password.length < 6) {
      return 'Your password have less than 6 characters!';
    }
    if (!RegExp(_uppercaseCharRegExp).hasMatch(password) ||
        !RegExp(_specialCharRegExp).hasMatch(password)) {
      return 'Password requires at least one special character and at least one uppercase letter.';
    }
    return null;
  }

  String? confirmPasswordValidator(String? password, String? confirmPassword) {
    if (password == confirmPassword) {
      return null;
    }
    return 'The passwords do not match.';
  }

  String? minNameLengthValidator(String? name) {
    if (name == null || name.length < 4) {
      return 'Please enter a name with at least 4 characters.';
    }
    return null;
  }

  final String _uppercaseCharRegExp = r'(?=.*[A-Z])';
  final String _specialCharRegExp =
      r"[?=.*[!@#\$%^&*()_+\-=[\]{};':\\\|,.<>\/?]+";
  // final String _validEmailRegExp =
  //     r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,6}$';
  final String _validEmailRegExp =
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,6}(?:\.[a-zA-Z]{2,6}){0,}$';
}