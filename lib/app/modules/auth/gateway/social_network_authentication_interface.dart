import 'package:google_sign_in/google_sign_in.dart';
import 'package:up_invest_front/app/modules/auth/credential_dto.dart';

sealed class ISocialAuthenticationGateway {
  Future<CredentialDTO> getCredential(String socialNetwork);
}

class SocialNetworkGateway extends ISocialAuthenticationGateway {
  @override
  Future<CredentialDTO> getCredential(String socialNetwork) async {
    switch (socialNetwork) {
      case 'google':
        return await _getGoogleCredential();
      case 'facebook':
        return await _getFacebookCredential();
      default:
        throw 'Invalid Social Network';
    }
  }

  Future<CredentialDTO> _getGoogleCredential() async {
    //Begin interactive sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //obtain auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    //create a new credential for user
    final CredentialDTO googleCredential = CredentialDTO(
        acessToken: googleAuth.accessToken!, idToken: googleAuth.idToken);
    return googleCredential;
  }

  Future<CredentialDTO> _getFacebookCredential() async {
    //Begin interactive sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //obtain auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    //create a new credential for user
    final CredentialDTO googleCredential = CredentialDTO(
        acessToken: googleAuth.accessToken!, idToken: googleAuth.idToken);
    return googleCredential;
  }
}
