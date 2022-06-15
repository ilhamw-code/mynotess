import 'package:firebase_core/firebase_core.dart';
import 'package:note/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  //ini interface untu provider
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
