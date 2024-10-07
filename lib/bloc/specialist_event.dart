abstract class SpecialistEvent {}

class SpecialistFetch extends SpecialistEvent {
  final Map<String, Object>? criteria;

  SpecialistFetch([this.criteria]);
}
