import 'package:firebase/services/auth/auth_exceptions.dart';
import 'package:firebase/services/auth/bloc/auth_bloc.dart';
import 'package:firebase/services/auth/bloc/auth_event.dart';
import 'package:firebase/services/auth/bloc/auth_state.dart';
import 'package:firebase/views/utilities/dialogs/error_dialog.dart';
import 'package:firebase/views/utilities/dialogs/show_sent_email_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: ((context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.exception is InputRequiredException) {
            await showErrorDialog(context, 'Input required');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Enter your email!');
          } else if (state.exception is ConnectFailedExistException) {
            await showErrorDialog(context, 'Connection error!');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Error');
          } else if (state.hasSentEmail == true) {
            await showSentEmailDialog(context);
          }
        }
      }),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _email,
                decoration: const InputDecoration(hintText: 'Enter your email'),
                autofocus: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(AuthEventForgotPassword(_email.text));
                },
                child: const Text('Send reset password'),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogout());
                },
                child: const Text('Back to Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
