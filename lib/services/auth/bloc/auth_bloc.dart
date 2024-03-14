import 'package:bloc/bloc.dart';
import 'package:firebase/services/auth/auth_provider.dart';
import 'package:firebase/services/auth/bloc/auth_event.dart';
import 'package:firebase/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    //initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLogout());
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedVerify());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    //login
    on<AuthEventLogin>((event, emit) async {
      emit(const AuthStateLoading());
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.login(
          email: email,
          password: password,
        );
        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthStateLoginFailure(e));
      }
    });

    //logout
    on<AuthEventLogout>((event, emit) async {
      try {
        emit(const AuthStateLoading());
        await provider.logout();
        emit(const AuthStateLogout());
      } on Exception catch (e) {
        emit(AuthStateLogoutFailure(e));
      }
    });
  }
}
