part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpRequested(this.email, this.password);
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);
}

class GoogleSignInRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class AuthStatusRequested extends AuthEvent {}

class TooglePasswordVisibility extends AuthEvent {}

class ResetPasswordLinkRequested extends AuthEvent {
  final String email;

  const ResetPasswordLinkRequested(this.email);
}
