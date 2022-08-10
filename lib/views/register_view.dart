import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/services/auth/auth_exception.dart';
import 'package:note/services/auth/bloc/auth_bloc.dart';
import 'package:note/utilities/dialog/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        if (state is AuthStateregistering) {
          if (state.exception is WeekPasswordAuthException) {
            await showDialogError(context, 'Week Password');
          } else if (state.exception is InvalidEmailAuthException) {
            await showDialogError(context, 'Invalid Email');
          } else if (state.exception is EmailAlreadyInUsedAuthException) {
            await showDialogError(context, 'Email already in Use');
          } else if (state.exception is GenericAuthException) {
            await showDialogError(context, 'Failed Register');
          }
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Register Here',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: _email,
                  autocorrect: false,
                  autofocus: true,
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
                      borderSide:
                          const BorderSide(color: Colors.teal, width: 2.0),
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
                  height: 7,
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.vpn_key,
                      color: Colors.teal,
                    ),
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.teal,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.teal, width: 2.0),
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
                  height: 25,
                ),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 3.0,
                            minimumSize: const Size(300, 50),
                            primary: Colors.teal),
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;

                          context.read<AuthBloc>().add(AuthEventRegister(
                                email,
                                password,
                              ));
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                const AuthEventLogOut(),
                              );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Already Registered? ',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'Login here',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      )
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
