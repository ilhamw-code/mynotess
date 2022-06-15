import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;

  const AuthUser(this.isEmailVerified);

// akan menginisialisasi class user dan akan mengembalikan nilai keAuth user
  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);

  sendEmailVerification() {}
}
