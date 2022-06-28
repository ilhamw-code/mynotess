import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';

@immutable
class AuthUser {
  // give field untuk email agar bisa di data pada DB
  final String? email;
  final bool isEmailVerified;

  const AuthUser({
    required this.email,
    required this.isEmailVerified,
  });

// akan menginisialisasi class user dan akan mengembalikan nilai keAuth user
  factory AuthUser.fromFirebase(User user) => AuthUser(
        isEmailVerified: user.emailVerified,
        email: user.email,
      );
}
