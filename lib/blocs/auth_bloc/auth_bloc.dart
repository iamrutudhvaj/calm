import 'package:bloc/bloc.dart';
import 'package:calm/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthState()) {
    on<SignUpRequested>(_signUp);

    on<LoginRequested>(_login);

    on<GoogleSignInRequested>(_signInWithGoogle);

    on<LogoutRequested>(_logout);

    on<AuthStatusRequested>(_getAuthStatus);

    on<TooglePasswordVisibility>(_tooglePasswordVisibility);

    on<ResetPasswordLinkRequested>(_resetPassword);
  }

  void _signUp(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.authLoading));
    try {
      await _authRepository.signUp(event.email, event.password);
      emit(state.copyWith(status: AuthStatus.authenticated));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(state.copyWith(
            status: AuthStatus.authError,
            errorMessage: "The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(state.copyWith(
            status: AuthStatus.authError,
            errorMessage: "The account already exists for that email."));
      }
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.authError, errorMessage: e.toString()));
    }
  }

  void _login(LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.authLoading));
    try {
      await _authRepository.login(event.email, event.password);
      emit(state.copyWith(status: AuthStatus.authenticated));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(state.copyWith(
            status: AuthStatus.authError,
            errorMessage: "No user found for that email."));
      } else if (e.code == 'wrong-password') {
        emit(state.copyWith(
            status: AuthStatus.authError,
            errorMessage: "Wrong password provided for that user."));
      }
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.authError, errorMessage: e.toString()));
    }
  }

  void _signInWithGoogle(
      GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.authLoading));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: AuthStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.authError, errorMessage: e.toString()));
    }
  }

  void _logout(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.authLoading));
    try {
      await _authRepository.logout();
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.authError, errorMessage: e.toString()));
    }
  }

  void _getAuthStatus(
      AuthStatusRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.authLoading));
    try {
      if ((await _authRepository.user) != null) {
        emit(state.copyWith(status: AuthStatus.authenticated));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.authError, errorMessage: e.toString()));
    }
  }

  void _tooglePasswordVisibility(
      TooglePasswordVisibility event, Emitter<AuthState> emit) {
    emit(state.copyWith(obsecuredText: !state.obsecuredText));
  }

  void _resetPassword(
      ResetPasswordLinkRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.authLoading));
    try {
      await _authRepository.sendPasswordResetEmail(event.email);
      emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: "Password reset link sent to your email"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(state.copyWith(
            status: AuthStatus.authError,
            errorMessage: "No user found for that email."));
      }
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.authError, errorMessage: e.toString()));
    }
  }
}
