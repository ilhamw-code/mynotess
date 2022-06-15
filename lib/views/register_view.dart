import 'package:flutter/material.dart';
import 'package:note/constans/routes.dart';
import 'package:note/services/auth/auth_exception.dart';
import 'package:note/services/auth/auth_service.dart';
import 'package:note/utilities/show_eror_dialog.dart';

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
    return Scaffold(
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
            decoration: const InputDecoration(hintText: 'Enter Your Password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );

                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on InvalidEmailAuthException {
                await showDialogError(
                  context,
                  'Invalid Email',
                );
              } on WeekPasswordAuthException {
                await showDialogError(
                  context,
                  'Weak Password',
                );
              } on EmailAlreadyInUsedAuthException {
                await showDialogError(
                  context,
                  'Email already in Use',
                );
              } on GenericAuthException {
                await showDialogError(
                  context,
                  'Failed Register',
                );
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already Registered? Login here'),
          )
        ],
      ),
    );
  }
}
