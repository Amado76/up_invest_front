import 'package:equatable/equatable.dart';

class AuthUserModel extends Equatable {
  final String userId;
  final String email;
  final String token;
  final String displayName;
  final String avatarPicture;
  final String signInMethod;
  final bool isEmailVerified;
  const AuthUserModel(
      {required this.userId,
      required this.email,
      required this.token,
      required this.displayName,
      required this.avatarPicture,
      required this.signInMethod,
      required this.isEmailVerified});

  @override
  List<Object?> get props => [
        userId,
        email,
        token,
        displayName,
        avatarPicture,
        signInMethod,
        isEmailVerified,
      ];
}
