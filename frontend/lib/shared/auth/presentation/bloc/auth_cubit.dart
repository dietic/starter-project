import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/entities/auth_user.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/exceptions/auth_exceptions.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/usecases/params/auth_credentials.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/usecases/sign_in.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/usecases/sign_out.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/usecases/sign_up.dart';
import 'package:news_app_clean_architecture/shared/auth/domain/usecases/watch_auth_state.dart';
import 'package:news_app_clean_architecture/shared/auth/presentation/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;
  final SignOutUseCase _signOut;
  final WatchAuthStateUseCase _watchAuthState;

  StreamSubscription<AuthUserEntity?>? _subscription;

  AuthCubit({
    required SignInUseCase signIn,
    required SignUpUseCase signUp,
    required SignOutUseCase signOut,
    required WatchAuthStateUseCase watchAuthState,
  })  : _signIn = signIn,
        _signUp = signUp,
        _signOut = signOut,
        _watchAuthState = watchAuthState,
        super(const AuthInitial()) {
    _subscription = _watchAuthState().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(AuthUserEntity? user) {
    if (user == null) {
      emit(const AuthUnauthenticated());
    } else {
      emit(AuthAuthenticated(user));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(const AuthLoading());
    try {
      await _signIn(params: AuthCredentials(email: email, password: password));
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(const AuthLoading());
    try {
      await _signUp(params: AuthCredentials(email: email, password: password));
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  Future<void> signOut() => _signOut();

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
