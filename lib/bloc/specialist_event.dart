abstract class SpecialistEvent {}

class SpecialistFetch extends SpecialistEvent {
  final Map<String, Object>? criteria;

  SpecialistFetch([this.criteria]);
}

class SpecialistInsert extends SpecialistEvent {
  Map<String, Object> values;

  SpecialistInsert(this.values);
}

class SpecialistDelete extends SpecialistEvent {
  int id;

  SpecialistDelete(this.id);
}
