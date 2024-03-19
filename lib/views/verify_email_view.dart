import 'package:firebase/services/auth/bloc/auth_bloc.dart';
import 'package:firebase/services/auth/bloc/auth_event.dart';
import 'package:firebase/services/auth/bloc/auth_state.dart';
import 'package:firebase/views/utilities/dialogs/sent_forgot_password_email_dialog.dart';
import 'package:firebase/views/utilities/dialogs/sent_verify_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateNeedVerify) {
          if (state.hasSentEmail == true) {
            sentVerifyEmailDialog(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50, 20, 20, 50),
          child: Column(
            children: [
              const Text("You need to authenticate before using the app"),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(const AuthEventSendEmailVerification());
                },
                child: const Text('Send email verification'),
              ),
              TextButton(
                onPressed: () async {
                  context.read<AuthBloc>().add(const AuthEventLogout());
                },
                child: const Text('Restart'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
