abstract class SpecialistEvent {}

class SpecialistFetch extends SpecialistEvent {
  final Map<String, Object>? criteria;

  SpecialistFetch([this.criteria]);
}

class SpecialistInsert extends SpecialistEvent {
  Map<String, Object> values;

  SpecialistInsert(this.values);
}
