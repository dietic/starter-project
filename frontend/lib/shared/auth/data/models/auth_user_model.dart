import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUserEntity {
  const AuthUserModel({
    required super.uid,
    super.email,
    super.emailVerified,
  });

  factory AuthUserModel.fromFirebaseUser(User user) {
    return AuthUserModel(
      uid: user.uid,
      email: user.email,
      emailVerified: user.emailVerified,
    );
  }
}
