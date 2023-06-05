import 'dart:async';

import 'package:flutter/material.dart' show visibleForTesting;
import 'package:up_invest_front/app/modules/auth/gateway/auth_gateway_interface.dart';
import 'package:up_invest_front/app/modules/auth/gateway/auth_social_network_gateway_interface.dart';
import 'package:up_invest_front/app/modules/auth/model/auth_user_model.dart';

import '../util/credential_dto.dart';

sealed class IAuthRepository {
  @visibleForTesting
  final IAuthGateway authGateway;
  @visibleForTesting
  final IAuthSocialNetworkGateway authSocialNetworkGateway;

  IAuthRepository(
      {required this.authSocialNetworkGateway, required this.authGateway});

  void addAuthUserToStream(AuthUserModel? authUserModel);

  Stream<AuthUserModel?> get authUser;

  Future<AuthUserModel> signInWithEmailAndPassword(
      String email, String password);

  Future<AuthUserModel> signInWithSocialNetwork(String socialNetwork);

  Future<AuthUserModel> createAccount(
      {required String email,
      required String password,
      required String displayName,
      required String avatar});

  Future<void> updatePassword({
    required String newPassword,
  });

  Future<AuthUserModel> updateAccountDetails({String? newName, String? avatar});

  Future<void> deleteUser();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();

  Future<bool> isUserSignedIn();

  Future<AuthUserModel> getLoggedUser();

  Future<void> reauthenticateAUser(String email, String password);
}

class AuthRepository extends IAuthRepository {
  AuthRepository(
      {required super.authSocialNetworkGateway, required super.authGateway});

  @override
  void addAuthUserToStream(AuthUserModel? authUserModel) =>
      controller.sink.add(authUserModel);

  @override
  Stream<AuthUserModel?> get authUser => controller.stream;

  @visibleForTesting
  final StreamController<AuthUserModel?> controller =
      StreamController<AuthUserModel?>.broadcast();

  @override
  Future<AuthUserModel> createAccount(
      {required String email,
      required String password,
      required String displayName,
      required String avatar}) async {
    AuthUserModel authUser =
        await authGateway.createAccount(email, password, displayName, avatar);
    return authUser;
  }

  @override
  Future<AuthUserModel> updateAccountDetails(
      {String? newName, String? avatar}) async {
    AuthUserModel authUser =
        await authGateway.updateAccountDetails(newName, avatar);

    return authUser;
  }

  @override
  @override
  Future<void> deleteUser() async {
    authGateway.deleteUser();
  }

  @override
  Future<bool> isUserSignedIn() async {
    return await authGateway.isUserSignedIn();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await authGateway.sendPasswordResetEmail(email);
  }

  @override
  Future<AuthUserModel> signInWithEmailAndPassword(
      String email, String password) async {
    AuthUserModel user =
        await authGateway.signInWithEmailAndPassword(email, password);
    return user;
  }

  @override
  Future<AuthUserModel> signInWithSocialNetwork(String socialNetwork) async {
    final CredentialDTO credential;
    final AuthUserModel authUser;

    credential = await getGoogleCredential();
    authUser =
        await authGateway.signInWithSocialNetwork(socialNetwork, credential);

    return authUser;
  }

  Future<CredentialDTO> getGoogleCredential() async {
    final CredentialDTO googleCredential;
    googleCredential = await authSocialNetworkGateway.getCredential('google');
    return googleCredential;
  }

  @override
  Future<void> signOut() async {
    authGateway.signOut();
  }

  @override
  @visibleForTesting
  Future<void> updatePassword({required String newPassword}) async {
    await authGateway.updatePassword(newPassword);
  }

  @override
  Future<AuthUserModel> getLoggedUser() async {
    return await authGateway.getLoggedUser();
  }

  @override
  Future<void> reauthenticateAUser(String email, String password) async {
    await authGateway.reauthenticateAUser(email, password);
  }
}
