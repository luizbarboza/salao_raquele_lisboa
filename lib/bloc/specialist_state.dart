import '../model/specialist.dart';

abstract class SpecialistState {}

class SpecialistInitial extends SpecialistState {}

class SpecialistFetched extends SpecialistState {
  final List<Specialist> specialist;

  SpecialistFetched(this.specialist);
}

class SpecialistError extends SpecialistState {
  final String message;

  SpecialistError(this.message);
}
