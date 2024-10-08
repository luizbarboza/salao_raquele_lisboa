import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String name;     // Novo parâmetro
  final String cpf;      // Novo parâmetro
  final String cell;     // Novo parâmetro
  final String email;
  final String password;

  SignUpRequested({
    required this.name,    // Exigido
    required this.cpf,     // Exigido
    required this.cell,    // Exigido
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, cpf, cell, email, password];  // Inclua os novos campos
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignOutRequested extends AuthEvent {}
