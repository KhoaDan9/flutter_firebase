import 'package:firebase/constants/routes.dart';
import 'package:firebase/services/auth/auth_exceptions.dart';
import 'package:firebase/services/auth/auth_service.dart';
import 'package:firebase/services/auth/bloc/auth_bloc.dart';
import 'package:firebase/services/auth/bloc/auth_event.dart';
import 'package:firebase/services/auth/bloc/auth_state.dart';
import 'package:firebase/views/utilities/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'Enter your password here'),
          ),
          Center(
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (state is AuthStateLogout) {
                  if (state.exception is WrongPasswordAuthException ||
                      state.exception is UserNotFoundAuthException ||
                      state.exception is WrongAuthException) {
                    await showErrorDialog(
                      context,
                      'Wrong credentials',
                    );
                  } else if (state.exception is GenericAuthException) {
                    await showErrorDialog(
                      context,
                      'Authentication error',
                    );
                  } else if (state.exception is InputRequiredException) {
                    await showErrorDialog(
                      context,
                      'Input required',
                    );
                  }
                }
              },
              child: TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  context.read<AuthBloc>().add(
                        AuthEventLogin(
                          email: email,
                          password: password,
                        ),
                      );
                },
                child: const Text('Dang nhap'),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Not registered yet? Register here!'),
          )
        ],
      ),
    );
  }
}
