import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_raquele_lisboa/data/person.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import '../data/address.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    Supabase.instance.client.auth.onAuthStateChange.listen(
      (data) {
        if (data.event == AuthChangeEvent.signedOut) {
          add(AuthSignedOut());
        }
      },
    );

    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignOutRequested>(_onSignOutResquested);
    on<AuthSignedOut>(_onSignedOut);
  }

  Future<void> _onCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        final person = await fetchPerson({"user": user.id});
        emit(AuthAuthenticated(person[0]));
        return;
      }
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(
        "Ocorreu um erro inesperado ao verificar sua autenticação. Tente novamente mais tarde.",
      ));
    }
  }

  Future<void> _onSignUpRequested(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: event.email,
        password: event.password,
      );
      final address = await insertAddress({
        "user": response.user!.id,
        "nome": event.name,
        "cpf": event.cpf,
        "data_nascimento": event.birthDate,
        "numero_telefone": event.phoneNumber,
      });
      final person = await insertPerson({
        "user": response.user!.id,
        "nome": event.name,
        "cpf": event.cpf,
        "data_nascimento": event.birthDate,
        "numero_telefone": event.phoneNumber,
        "endereco": address.id,
      });
      emit(AuthAuthenticated(person));
    } on AuthException catch (_) {
      emit(AuthError(
        "Ocorreu um erro ao fazer o cadastro. Verifique os dados inseridos e tente novamente!",
      ));
    } catch (e) {
      emit(AuthError(
        "Ocorreu um erro inesperado ao fazer o cadastro. Tente novamente mais tarde.",
      ));
    }
  }

  Future<void> _onSignInRequested(
      AuthSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      final person = await fetchPerson({"user": response.user!.id});
      emit(AuthAuthenticated(person[0]));
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

  Future<void> _onSignOutResquested(
      AuthSignOutRequested event, Emitter<AuthState> emit) async {
    try {
      await Supabase.instance.client.auth.signOut();
      //emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(
        "Ocorreu um erro ao tentar sair. Tente novamente!",
      ));
    }
  }

  Future<void> _onSignedOut(
      AuthSignedOut event, Emitter<AuthState> emit) async {
    emit(AuthUnauthenticated());
  }
}
