import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String cpf;
  final String birthDate;
  final String phoneNumber;
  final String cep;
  final String federativeUnit;
  final String municipality;
  final String neighborhood;
  final String publicPlace;
  final String number;
  final String complement;

  AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.phoneNumber,
    required this.cep,
    required this.federativeUnit,
    required this.municipality,
    required this.neighborhood,
    required this.publicPlace,
    required this.number,
    required this.complement,
  });

  @override
  List<Object> get props => [
        email,
        password,
        name,
        cpf,
        birthDate,
        phoneNumber,
        cep,
        federativeUnit,
        municipality,
        neighborhood,
        publicPlace,
        number,
        complement,
      ];
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignInRequested(this.email, this.password);
}

class AuthSignOutRequested extends AuthEvent {}

class AuthSignedOut extends AuthEvent {}
