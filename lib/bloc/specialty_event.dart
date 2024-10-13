abstract class SpecialtyEvent {}

class SpecialtyFetch extends SpecialtyEvent {}

class SpecialtyInsert extends SpecialtyEvent {
  Map<String, Object> values;

  SpecialtyInsert(this.values);
}
