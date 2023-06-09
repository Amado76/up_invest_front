// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:up_invest_front/app/modules/auth/bloc/auth_bloc.dart';

void main() {
  const String email = '';
  const String password = '';
  const String socialNetwork = '';
  group('[AuthSignInWithEmailAndPassword]', () {
    test('supports value comparisons', () {
      expect(AuthSignInWithEmailAndPassword(email: email, password: password),
          AuthSignInWithEmailAndPassword(email: email, password: password));
    });
  });
  group('[AuthSignInWithSocialNetwork]', () {
    test('supports value comparisons', () {
      expect(
        AuthSignInWithSocialNetwork(socialNetwork: socialNetwork),
        AuthSignInWithSocialNetwork(socialNetwork: socialNetwork),
      );
    });
  });
  group('[AuthDeleteAccount]', () {
    test('supports value comparisons', () {
      expect(AuthDeleteAccount(email: email, password: password),
          AuthDeleteAccount(email: email, password: password));
    });
  });
  group('[AuthLogOut]', () {
    test('supports value comparisons', () {
      expect(AuthLogOut(), AuthLogOut());
    });
  });

  group('[AuthIsLoggedIn]', () {
    test('supports value comparisons', () {
      expect(AuthIsLoggedIn(), AuthIsLoggedIn());
    });
  });

  group('[AuthSendEmailVerification]', () {
    test('supports value comparisons', () {
      expect(AuthSendEmailVerification(), AuthSendEmailVerification());
    });
  });
}
