abstract class PersonEvent {}

class PersonFetch extends PersonEvent {
  final Map<String, Object>? criteria;

  PersonFetch([this.criteria]);
}
