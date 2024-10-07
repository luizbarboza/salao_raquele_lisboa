import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUp);
    on<SignInRequested>(_onSignIn);
    on<SignOutRequested>(_onSignOut);
  }

  Future<void> _onSignUp(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(response.user!));
    } on AuthException catch (_) {
      emit(AuthError(
        "Ocorreu um erro ao fazer o login. Verifique os dados inseridos e tente novamente!",
      ));
    } catch (e) {
      emit(AuthError(
        "Ocorreu um erro inesperado ao fazer o login. Tente novamente mais tarde.",
      ));
    }
  }

  Future<void> _onSignIn(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(response.user!));
    } on AuthException catch (_) {
      emit(AuthError(
        "Ocorreu um erro ao fazer o login. Verifique os dados inseridos e tente novamente!",
      ));
    } catch (e) {
      emit(AuthError(
        "Ocorreu um erro inesperado ao fazer o login. Tente novamente mais tarde.",
      ));
    }
  }

  Future<void> _onSignOut(
      SignOutRequested event, Emitter<AuthState> emit) async {
    try {
      await Supabase.instance.client.auth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(
        "Ocorreu um erro ao tentar sair. Tente novamente!",
      ));
    }
  }
}
