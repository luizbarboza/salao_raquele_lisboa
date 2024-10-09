import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String cpf;
  final String birthDate;
  final String address;
  final String phoneNumber;

  SignUpRequested({
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

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignOutRequested extends AuthEvent {}
