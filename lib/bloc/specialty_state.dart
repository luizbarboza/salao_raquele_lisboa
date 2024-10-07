import '../model/specialty.dart';

abstract class SpecialtyState {}

class SpecialtyInitial extends SpecialtyState {}

class SpecialtyFetching extends SpecialtyState {}

class SpecialtyFetchedAll extends SpecialtyState {
  final List<Specialty> specialties;

  SpecialtyFetchedAll(this.specialties);
}

class SpecialtyError extends SpecialtyState {
  final String message;

  SpecialtyError(this.message);
}
