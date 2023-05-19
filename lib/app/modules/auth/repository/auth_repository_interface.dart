import 'package:up_invest_front/app/modules/auth/gateway/auth_gateway_interface.dart';
import 'package:up_invest_front/app/modules/auth/model/auth_user_model.dart';

abstract class IAuthRepository {
  final IAuthGateway authGateway;

  Future<AuthUserModel> signInWithEmailAndPassword(
      String email, String password);
  Future<AuthUserModel> signInWithSocialNetwork(
      String email, String socialNetwork);
  Future<AuthUserModel> createAccount(
      String email, String password, String displayName, String avatarPicture);
  Future<void> updatePassword(
      String oldPassword, String newPassword, String email);
  Future<void> deleteUser(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<bool> isUserSignedIn();
  Future<AuthUserModel> getLoggedUser();

  IAuthRepository({required this.authGateway});
}
