import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/constans/routes.dart';
import 'package:note/helper/loading/loading_screen.dart';
import 'package:note/services/auth/bloc/auth_bloc.dart';
import 'package:note/services/auth/firebase_auth_provider.dart';
import 'package:note/views/forgot_password_view.dart';
import 'package:note/views/login_view.dart';
import 'package:note/views/note/create_update_view.dart';
import 'package:note/views/note/notes_view.dart';
import 'package:note/views/register_view.dart';
import 'package:note/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        // this link Route
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingtext ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateregistering) {
          return const RegisterView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPassword();
        } else {
          return const Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            body: Center(
              child: CircularProgressIndicator(color: Colors.teal),
            ),
          );
        }
      },
    );
  }
}
