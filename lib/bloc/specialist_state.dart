import '../model/specialist.dart';

abstract class SpecialistState {}

class SpecialistInitial extends SpecialistState {}

class SpecialistFetching extends SpecialistState {}

class SpecialistFetched extends SpecialistState {
  final List<Specialist> specialists;

  SpecialistFetched(this.specialists);
}

class SpecialistInserting extends SpecialistState {}

class SpecialistInserted extends SpecialistState {
  final Specialist specialist;

  SpecialistInserted(this.specialist);
}

class SpecialistError extends SpecialistState {
  final String message;

  SpecialistError(this.message);
}
