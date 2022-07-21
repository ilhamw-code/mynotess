part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingtext;
  const AuthState({
    required this.isLoading,
    this.loadingtext = 'Please Wait a Moment',
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required isLoading})
      : super(isLoading: isLoading);
}

class AuthStateregistering extends AuthState {
  final Exception? exception;
  const AuthStateregistering({
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;

  const AuthStateForgotPassword({
    required this.exception,
    required this.hasSentEmail,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateNeedVerification extends AuthState {
  const AuthStateNeedVerification({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(
          isLoading: isLoading,
          loadingtext: loadingText,
        );

  @override
  List<Object?> get props => [exception, isLoading];
}
