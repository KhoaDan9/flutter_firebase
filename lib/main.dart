import 'package:firebase/constants/routes.dart';
import 'package:firebase/services/auth/bloc/auth_bloc.dart';
import 'package:firebase/services/auth/bloc/auth_event.dart';
import 'package:firebase/services/auth/bloc/auth_state.dart';
import 'package:firebase/services/auth/firebase_auth_provider.dart';
import 'package:firebase/views/login_view.dart';
import 'package:firebase/views/notes/create_update_note_view.dart';
import 'package:firebase/views/notes/notes_view.dart';
import 'package:firebase/views/register_view.dart';
import 'package:firebase/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // initialRoute: homeRoute,
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: const HomePage(),
    ),
    routes: {
      // homeRoute: (context) => const HomePage(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
      createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: ((context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateLogout) {
          return const LoginView();
        } else if (state is AuthStateNeedVerify) {
          return const VerifyEmailView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
