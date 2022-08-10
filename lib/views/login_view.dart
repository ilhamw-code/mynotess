import 'package:flutter/material.dart';
import 'package:note/services/auth/auth_exception.dart';
import 'package:note/services/auth/bloc/auth_bloc.dart';
import 'package:note/utilities/dialog/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showDialogError(
                context, 'Connot find a user with the entered credential!');
          }
          if (state.exception is WrongPasswordAuthException) {
            await showDialogError(context, 'Wrong Password');
          }
          if (state.exception is GenericAuthException) {
            await showDialogError(context, 'Sorry You Have an Error');
          }
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Hello,',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal),
                ),
                const Text(
                  'Log In to Your Account',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _email,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.email,
                            color: Colors.teal,
                          ),
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                            color: Colors.teal,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.teal, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                                color: Colors.teal,
                                style: BorderStyle.solid,
                                width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.teal, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                                color: Colors.teal,
                                style: BorderStyle.solid,
                                width: 2.0),
                          ),
                          suffixIcon: const Icon(
                            Icons.vpn_key,
                            color: Colors.teal,
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              final email = _email.text;
                              context.read<AuthBloc>().add(
                                    AuthEventForgotPassword(email: email),
                                  );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 3.0,
                            minimumSize: const Size(300, 50),
                            primary: Colors.teal),
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          context.read<AuthBloc>().add(
                                AuthEventLogIn(
                                  email,
                                  password,
                                ),
                              );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                const AuthEventShouldRegister(),
                              );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Not Register yet?  ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            Text('Register Here',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.underline,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
