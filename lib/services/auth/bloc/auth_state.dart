import 'package:firebase/services/auth/auth_user.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateNeedVerify extends AuthState {
  const AuthStateNeedVerify();
}

class AuthStateLogout extends AuthState {
  final Exception? exception;
  const AuthStateLogout(this.exception);
}

class AuthStateLogoutFailure extends AuthState {
  final Exception exception;
  const AuthStateLogoutFailure(this.exception);
}
