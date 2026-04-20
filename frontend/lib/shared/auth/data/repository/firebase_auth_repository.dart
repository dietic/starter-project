import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_clean_architecture/shared/auth/data/data_sources/firebase_auth_data_source.dart';
import 'package:news_app_clean_architecture/shared/auth/data/models/auth_user_model.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/entities/auth_user.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/exceptions/auth_exceptions.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/repository/auth_repository.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/usecases/params/auth_credentials.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  FirebaseAuthRepository(this._dataSource);

  @override
  Stream<AuthUserEntity?> authStateChanges() => _dataSource
      .authStateChanges()
      .map((u) => u == null ? null : AuthUserModel.fromFirebaseUser(u));

  @override
  AuthUserEntity? get currentUser {
    final u = _dataSource.currentUser;
    return u == null ? null : AuthUserModel.fromFirebaseUser(u);
  }

  @override
  Future<AuthUserEntity> signIn(AuthCredentials credentials) async {
    try {
      final user = await _dataSource.signInWithEmailAndPassword(
        credentials.email.trim(),
        credentials.password,
      );
      return AuthUserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<AuthUserEntity> signUp(AuthCredentials credentials) async {
    try {
      final user = await _dataSource.createUserWithEmailAndPassword(
        credentials.email.trim(),
        credentials.password,
      );
      return AuthUserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<void> signOut() => _dataSource.signOut();

  AuthException _mapException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return const InvalidCredentialsException();
      case 'email-already-in-use':
        return const EmailAlreadyInUseException();
      case 'weak-password':
        return const WeakPasswordException();
      case 'invalid-email':
        return const InvalidEmailException();
      default:
        return AuthUnknownException(e.message ?? e.code);
    }
  }
}
