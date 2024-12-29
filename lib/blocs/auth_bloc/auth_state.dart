part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  authLoading,
  authError
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String errorMessage;
  final bool obsecuredText;
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage = '',
    this.obsecuredText = true,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    bool? obsecuredText,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      obsecuredText: obsecuredText ?? this.obsecuredText,
    );
  }

  @override
  String toString() {
    return 'AuthState(status: $status, errorMessage: $errorMessage, obsecuredText: $obsecuredText)';
  }

  @override
  List<Object> get props => [status, errorMessage, obsecuredText];
}
