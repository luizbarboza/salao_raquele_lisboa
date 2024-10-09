abstract class AppointmentEvent {}

class AppointmentFetch extends AppointmentEvent {}

class AppointmentInsert extends AppointmentEvent {
  Map<String, Object> values;

  AppointmentInsert(this.values);
}
