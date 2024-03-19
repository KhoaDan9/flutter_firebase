import 'package:bloc/bloc.dart';
import 'package:firebase/services/auth/auth_provider.dart';
import 'package:firebase/services/auth/bloc/auth_event.dart';
import 'package:firebase/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    //initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(
          const AuthStateLogout(
            exception: null,
            isLoading: false,
          ),
        );
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedVerify(hasSentEmail: false));
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    //login
    on<AuthEventLogin>((event, emit) async {
      emit(
        const AuthStateLogout(
          exception: null,
          isLoading: true,
        ),
      );
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.login(
          email: email,
          password: password,
        );
        emit(
          const AuthStateLogout(
            exception: null,
            isLoading: false,
          ),
        );
        if (!user.isEmailVerified) {
          emit(const AuthStateNeedVerify(hasSentEmail: false));
        } else {
          emit(AuthStateLoggedIn(user));
        }
      } on Exception catch (e) {
        emit(
          AuthStateLogout(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });

    //logout
    on<AuthEventLogout>((event, emit) async {
      try {
        await provider.logout();
        emit(const AuthStateLogout(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLogout(exception: e, isLoading: false));
      }
    });

    //send email validation
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(const AuthStateNeedVerify(hasSentEmail: true));
    });

    //register
    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(
          email: email,
          password: password,
        );
        emit(const AuthStateNeedVerify(hasSentEmail: false));
      } on Exception catch (e) {
        emit(AuthStateRegistering(e));
      }
    });

    //go register
    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(null));
    });

    //forgot password
    on<AuthEventForgotPassword>((event, emit) async {
      final email = event.email;
      if (email == null) {
        emit(const AuthStateForgotPassword(
            exception: null, hasSentEmail: false));
      } else {
        try {
          await provider.forgotPassword(email: email);
          emit(const AuthStateForgotPassword(
              exception: null, hasSentEmail: true));
        } on Exception catch (e) {
          emit(AuthStateForgotPassword(exception: e, hasSentEmail: false));
        }
      }
    });
  }
}
