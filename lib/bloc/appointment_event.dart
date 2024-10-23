import '../model/person.dart';

abstract class AppointmentEvent {}

class AppointmentFetch extends AppointmentEvent {
  final Map<String, Object>? criteria;

  AppointmentFetch([this.criteria]);
}

class AppointmentPersonFetch extends AppointmentEvent {
  final Person person;

  AppointmentPersonFetch(this.person);
}

class AppointmentInsert extends AppointmentEvent {
  Map<String, Object> values;

  AppointmentInsert(this.values);
}

class AppointmentDelete extends AppointmentEvent {
  int id;

  AppointmentDelete(this.id);
}
