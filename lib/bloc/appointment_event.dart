abstract class AppointmentEvent {}

class AppointmentFetch extends AppointmentEvent {
  final Map<String, Object>? criteria;

  AppointmentFetch([this.criteria]);
}

class AppointmentInsert extends AppointmentEvent {
  Map<String, Object> values;

  AppointmentInsert(this.values);
}
