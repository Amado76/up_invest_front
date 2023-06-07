import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:up_invest_front/app/modules/auth/gateway/auth_gateway_interface.dart';
import 'package:up_invest_front/app/modules/auth/model/auth_user_model.dart';
import 'package:up_invest_front/app/modules/auth/util/credential_dto.dart';
import '../../../../mocks/auth/firebase/firebase_auth_mocks.dart';

class CredentialDTOMock extends Mock implements CredentialDTO {}

Future<void> main() async {
  group('[AuthGateway]', () {
    late UserMock userMock;
    late FirebaseAuthMock firebaseAuthMock;
    late UserCredentialMock userCredentialMock;
    late FireBaseGateway firebaseGateway;

    setUp(() {
      userMock = UserMock();
      firebaseAuthMock = FirebaseAuthMock();
      userCredentialMock = UserCredentialMock();
      firebaseGateway = FireBaseGateway(auth: firebaseAuthMock);

      when(() => firebaseAuthMock.currentUser!).thenReturn(userMock);
    });

    group('IAuthGateway', () {
      test('should initialize with the provided auth', () {
        // Arrange
        FirebaseAuthMock auth = FirebaseAuthMock();

        // Act
        final authGateway = FireBaseGateway(auth: auth);

        // Assert
        expect(authGateway.auth, equals(auth));
      });
    });

    group('[createUserWithEmailAndPassword]', () {
      test('should return an [AuthUserModel]', () async {
        //Arrange
        // Configure the FirebaseAuth mock to return the UserCredential mock
        when(() => firebaseAuthMock.createUserWithEmailAndPassword(
            email: 'email',
            password: 'password')).thenAnswer((_) async => userCredentialMock);

        //Act
        AuthUserModel newAccount =
            await firebaseGateway.createAccount('email', 'password');

        //Assert
        expect(newAccount, const TypeMatcher<AuthUserModel>());
      });
    });
    group('[signInWithEmailAndPassword]', () {
      test(
          'should return an [AuthUserModel] after successful sign-in with email and password]',
          () async {
        //Arrange
        // Configure the FirebaseAuth mock to return the UserCredential mock
        when(() => firebaseAuthMock.signInWithEmailAndPassword(
            email: 'email',
            password: 'password')).thenAnswer((_) async => userCredentialMock);

        //Act
        AuthUserModel signInWithEmailAndPassword = await firebaseGateway
            .signInWithEmailAndPassword('email', 'password');

        //Assert
        expect(signInWithEmailAndPassword, const TypeMatcher<AuthUserModel>());
      });
    });

    group('[signInWithSocialNetwork]', () {
      test(
          'should return an [AuthUserModel] after successful [sign-in with Google account]',
          () async {
        //Act
        AuthUserModel signInWithGoogle =
            await firebaseGateway.signInWithSocialNetwork(
                'google', CredentialDTO(acessToken: 'acessToken', idToken: ''));

        //Assert

        expect(signInWithGoogle, const TypeMatcher<AuthUserModel>());
      });
      test(
          'should return an [AuthUserModel] after successful [sign-in with Facebook account]',
          () async {
        //Act
        AuthUserModel signInWithGoogle =
            await firebaseGateway.signInWithSocialNetwork(
                'facebook', CredentialDTO(acessToken: 'acessToken'));

        //Assert

        expect(signInWithGoogle, const TypeMatcher<AuthUserModel>());
      });
      test(
          'Should throw an [exception] if an invalid sign-in option is received',
          () async {
        //Act
        try {
          await firebaseGateway.signInWithSocialNetwork(
              'orkut', CredentialDTO(acessToken: 'acessToken'));
        } catch (e) {
          //Assert
          expect(e.toString(), ('Exception: invalid-social-network'));
        }
      });
    });

    group('[getLoggedUser]', () {
      test(
          'should return an [AuthUserModel] after requesting the [logged-in user]',
          () async {
        //Act
        AuthUserModel signedInUser = await firebaseGateway.getLoggedUser();

        //Assert
        expect(signedInUser, const TypeMatcher<AuthUserModel>());
      });
    });

    group('[isUserSignedIn]', () {
      test('should return [false] when there is no logged-in user', () async {
        //Arrange
        when(() => firebaseAuthMock.authStateChanges())
            .thenAnswer((_) => Stream.fromIterable([null]));
        //Act
        bool isSignedIn = await firebaseGateway.isUserSignedIn();
        //Assert
        expect(isSignedIn, false);
      });

      test('should return [false] when the user logout', () async {
        //Arrange
        bool isSignedIn = true;
        when(() => firebaseAuthMock.authStateChanges())
            .thenAnswer((_) => Stream.fromIterable([null]));

        //Act
        isSignedIn = await firebaseGateway.isUserSignedIn();
        //Assert
        expect(isSignedIn, false);
      });

      test('should return [true] when the user is logged', () async {
        //Arrange

        when(() => firebaseAuthMock.authStateChanges())
            .thenAnswer((_) => Stream.fromIterable([userMock]));

        //Act
        bool isSignedIn = await firebaseGateway.isUserSignedIn();
        //Assert
        expect(isSignedIn, true);
      });
    });

    group('[deleteUser]', () {
      test('should call [FirebaseAuth.currentuser!.delete()', () async {
        //Assert

        when(() => userMock.delete()).thenAnswer((_) => Future.value());
        //Act
        firebaseGateway.deleteUser();
        //Assert

        verify(() => userMock.delete()).called(1);
      });
    });
    group('[sendPasswordResetEmail]', () {
      test('should call [FirebaseAuth.sendPasswordResetEmail()', () async {
        //Assert

        when(() => firebaseAuthMock.sendPasswordResetEmail(email: 'email'))
            .thenAnswer((_) => Future.value());
        //Act
        firebaseGateway.sendPasswordResetEmail('email');
        //Assert

        verify(() => firebaseAuthMock.sendPasswordResetEmail(email: 'email'))
            .called(1);
      });
    });
    group('[signOut]', () {
      test('should call [FirebaseAuth.signOut()', () async {
        //Assert

        when(() => firebaseAuthMock.signOut())
            .thenAnswer((_) => Future.value());
        //Act
        firebaseGateway.signOut();
        //Assert

        verify(() => firebaseAuthMock.signOut()).called(1);
      });
    });
    group('[updatePassword]', () {
      test('should call [FirebaseAuth.updatePassword()', () async {
        //Assert

        when(() => userMock.updatePassword('new'))
            .thenAnswer((_) => Future.value());
        //Act
        firebaseGateway.updatePassword('new');
        //Assert

        verify(() => firebaseAuthMock.currentUser!.updatePassword('new'))
            .called(1);
      });
    });
    group('[reauthenticateAUser]', () {
      test(
          'should call [FirebaseAuth.currentUser!.reauthenticateWithCredential',
          () async {
        //Assert
        registerFallbackValue(AuthCredentialMock());
        when(() => userMock.reauthenticateWithCredential(any()))
            .thenAnswer((_) async => userCredentialMock);
        //Act
        firebaseGateway.reauthenticateAUser('password', 'email');
        //Assert

        verify(() => userMock.reauthenticateWithCredential(any())).called(1);
      });
    });
    group('[updateAccountDetails]', () {
      test(
          'should call [FirebaseAuth.currentUser!.updatePhoto and return [AuthUser]',
          () async {
        //Assert
        when(() => firebaseAuthMock.currentUser!.updatePhotoURL('photoURL'))
            .thenAnswer((_) => Future.value(null));
        when(() => firebaseAuthMock.currentUser).thenAnswer((_) => UserMock());
        //Act
        AuthUserModel authUser =
            await firebaseGateway.updateAccountDetails(avatar: 'photoURL');
        //Assert

        verify(() => firebaseAuthMock.currentUser!.updatePhotoURL(any()))
            .callCount;
        verifyNever(
            () => firebaseAuthMock.currentUser!.updateDisplayName(any()));

        expect(authUser, isA<AuthUserModel>());
      });
      test(
          'should call [FirebaseAuth.currentUser!.updateDisplayName and return [AuthUser]',
          () async {
        //Assert
        when(() => firebaseAuthMock.currentUser!.updateDisplayName('name'))
            .thenAnswer((_) => Future.value(null));
        when(() => firebaseAuthMock.currentUser).thenAnswer((_) => UserMock());
        //Act
        AuthUserModel authUser =
            await firebaseGateway.updateAccountDetails(displayName: 'name');
        //Assert

        verify(() => firebaseAuthMock.currentUser!.updateDisplayName(any()))
            .callCount;
        verifyNever(() => firebaseAuthMock.currentUser!.updatePhotoURL(any()));

        expect(authUser, isA<AuthUserModel>());
      });
    });
  });
}
