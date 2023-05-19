import 'package:firebase_auth/firebase_auth.dart';
import 'package:up_invest_front/app/modules/auth/credential_dto.dart';

import 'package:up_invest_front/app/modules/auth/gateway/auth_gateway_interface.dart';
import 'package:up_invest_front/app/modules/auth/model/auth_user_model.dart';

class FireBaseGateway implements IAuthGateway {
  @override
  FirebaseAuth auth;
  FireBaseGateway({
    required this.auth,
  });

  @override

  /// Create a new account using e-mail and password
  Future<AuthUserModel> createAccount(
      String email, String password, String displayName, String avatar) async {
    UserCredential userCredential;
    userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await updatePhoto(avatar);
    await updateDisplayName(displayName);
    AuthUserModel authUser =
        await geAuthtUserModelFromUserCredential(userCredential);

    return authUser;
  }

  @override

  /// Sing In usigin the e-mail and password method
  Future<AuthUserModel> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    AuthUserModel authUserModel =
        await geAuthtUserModelFromUserCredential(userCredential);
    return authUserModel;
  }

  /// Sign in using a social network method. The gateway will select the right social network to use.
  ///
  /// Parameters:
  /// - socialNetwork: The social network to sign in with ('facebook' or 'google').
  /// - credentialDTO: The credential data required for the sign-in process.
  ///
  /// Returns: A Future that resolves to an AuthUserModel representing the signed-in user.
  @override
  Future<AuthUserModel> signInWithSocialNetwork(
      String socialNetwork, CredentialDTO credentialDTO) async {
    switch (socialNetwork) {
      case 'google':
        return await signInWithGoogle(credentialDTO);
      case 'facebook':
        return await signInWithFacebook(credentialDTO);
      default:
        throw 'Invalid Social Network';
    }
  }

  /// Specific rules to sing in with Facebook
  Future<AuthUserModel> signInWithFacebook(CredentialDTO credentialDTO) async {
    final OAuthCredential facebookAuthCredential;
    facebookAuthCredential =
        FacebookAuthProvider.credential(credentialDTO.acessToken);
    UserCredential userCredential =
        await auth.signInWithCredential(facebookAuthCredential);
    return await geAuthtUserModelFromUserCredential(userCredential);
  }

  /// Specific rules to sing in with Google
  Future<AuthUserModel> signInWithGoogle(CredentialDTO credentialDTO) async {
    final OAuthCredential googleAuthCredential;
    googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: credentialDTO.acessToken, idToken: credentialDTO.idToken);
    UserCredential userCredential =
        await auth.signInWithCredential(googleAuthCredential);
    return await geAuthtUserModelFromUserCredential(userCredential);
  }

  /// Update the username, if it doesn't return any exception, it was successful.
  @override
  Future<void> updateDisplayName(String newDisplayName) async {
    await auth.currentUser!.updateDisplayName(newDisplayName);
  }

  /// Update the Avatar Picture, if it doesn't return any exception, it was successful.
  @override
  Future<void> updatePhoto(String newAvatar) async {
    await auth.currentUser!.updatePhotoURL(newAvatar);
  }

  /// Delete and logout the user, this method requires a recent login for security.
  @override
  Future<void> deleteUser() async {
    await auth.currentUser!.delete();
  }

  @override

  /// Listens for User modifications and communicates if there was any sign in or sign out process
  Future<bool> isUserSignedIn() async {
    bool isSignedIn = false;

    await for (User? user in auth.authStateChanges()) {
      if (user != null) {
        isSignedIn = true;
        break;
      }
      isSignedIn = false;
      break;
    }
    return isSignedIn;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  /// Update password, this method requires a recent login for security.
  @override
  Future<void> updatePassword(
      String oldPassword, String newPassword, String email) async {
    await reauthenticateAUser(email, oldPassword);
    await auth.currentUser?.updatePassword(newPassword);
  }

  /// Re Authenticate the user to generate a recent login

  @override
  Future<void> reauthenticateAUser(String email, String password) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    await auth.currentUser?.reauthenticateWithCredential(credential);
  }

  @override
  Future<AuthUserModel> getLoggedUser() async {
    AuthUserModel authUserModel;
    User? firebaseUser = auth.currentUser;
    authUserModel = await getAuthUserModelFromUser(firebaseUser);
    return authUserModel;
  }

  /// Convert the UserCredential (Firebase Object) to AuthUserModel
  Future<AuthUserModel> geAuthtUserModelFromUserCredential(
      UserCredential userCredential) async {
    AuthUserModel authUser = AuthUserModel(
        userId: userCredential.user?.uid ?? '',
        email: userCredential.user?.email ?? '',
        token: await userCredential.user?.getIdToken() ?? '',
        displayName: userCredential.user?.displayName ?? '',
        avatarPicture: userCredential.user?.photoURL ?? 'default',
        signInMethod: userCredential.credential?.signInMethod ?? '',
        isEmailVerified: userCredential.user?.emailVerified ?? false);
    return authUser;
  }

  Future<AuthUserModel> getAuthUserModelFromUser(User? user) async {
    AuthUserModel authUser = AuthUserModel(
        userId: user?.uid ?? '',
        email: user?.email ?? '',
        token: await user?.getIdToken() ?? '',
        displayName: user?.displayName ?? '',
        avatarPicture: user?.photoURL ?? 'default',
        signInMethod: user?.providerData[0].providerId ?? '',
        isEmailVerified: user?.emailVerified ?? false);
    return authUser;
  }
}
