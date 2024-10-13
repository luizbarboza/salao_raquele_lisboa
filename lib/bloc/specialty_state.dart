import '../model/specialty.dart';

abstract class SpecialtyState {}

class SpecialtyInitial extends SpecialtyState {}

class SpecialtyFetching extends SpecialtyState {}

class SpecialtyFetched extends SpecialtyState {
  final List<Specialty> specialties;

  SpecialtyFetched(this.specialties);
}

class SpecialtyInserting extends SpecialtyState {}

class SpecialtyInserted extends SpecialtyState {
  final Specialty specialty;

  SpecialtyInserted(this.specialty);
}

class SpecialtyError extends SpecialtyState {
  final String message;

  SpecialtyError(this.message);
}
