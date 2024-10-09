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
  final String address;
  final String phoneNumber;

  AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.address,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [
        email,
        password,
        name,
        cpf,
        birthDate,
        address,
        phoneNumber,
      ];
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignInRequested(this.email, this.password);
}

class AuthSignOutRequested extends AuthEvent {}

class AuthSignedOut extends AuthEvent {}
