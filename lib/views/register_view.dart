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
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _email,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: 'Enter Your Password'),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                context.read<AuthBloc>().add(AuthEventRegister(
                      email,
                      password,
                    ));
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
              },
              child: const Text('Already Registered? Login here'),
            )
          ],
        ),
      ),
    );
  }
}
