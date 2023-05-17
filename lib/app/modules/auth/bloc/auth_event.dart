// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

@immutable
sealed class AuthEvent {}

@immutable
class AuthEventSignInWithEmailAndPassword implements AuthEvent {
  final String email;
  final String password;

  const AuthEventSignInWithEmailAndPassword({
    required this.email,
    required this.password,
  });
}

@immutable
class AuthEventSignInWithSocialNetwork implements AuthEvent {
  final String socialNetwork;

  const AuthEventSignInWithSocialNetwork({
    required this.socialNetwork,
  });
}

@immutable
class AuthEventDeleteAccount implements AuthEvent {
  const AuthEventDeleteAccount();
}

@immutable
class AuthEventLogOut implements AuthEvent {
  const AuthEventLogOut();
}

@immutable
class AuthEventCreateNewUser implements AuthEvent {
  final String email;
  final String password;
  final String displayName;
  final String avatar;
  const AuthEventCreateNewUser({
    required this.email,
    required this.password,
    required this.displayName,
    required this.avatar,
  });
}

@immutable
class AuthEventUpdatePassword implements AuthEvent {
  final String email;
  final String oldPassword;
  final String newPassword;

  const AuthEventUpdatePassword({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
  });
}

@immutable
class AuthEventUpdateAvatar implements AuthEvent {
  final String avatar;

  const AuthEventUpdateAvatar({
    required this.avatar,
  });
}

@immutable
class AuthEventUpdateDisplayName implements AuthEvent {
  final String displayName;

  const AuthEventUpdateDisplayName({
    required this.displayName,
  });
}

@immutable
class AuthEventPasswordReset implements AuthEvent {
  final String email;

  const AuthEventPasswordReset({
    required this.email,
  });
}

@immutable
class AuthEventGoToRegistrationPage implements AuthEvent {
  const AuthEventGoToRegistrationPage();
}

@immutable
class AuthEventGoToSignInPage implements AuthEvent {
  const AuthEventGoToSignInPage();
}

@immutable
class AuthEventGoToRecoverPasswordPage implements AuthEvent {
  const AuthEventGoToRecoverPasswordPage();
}

@immutable
class AuthEventGoToHomePage implements AuthEvent {
  const AuthEventGoToHomePage();
}