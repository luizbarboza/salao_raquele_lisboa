import '../model/person.dart';

abstract class PersonState {}

class PersonInitial extends PersonState {}

class PersonFetched extends PersonState {
  final List<Person> people;

  PersonFetched(this.people);
}

class PersonError extends PersonState {
  final String message;

  PersonError(this.message);
}
