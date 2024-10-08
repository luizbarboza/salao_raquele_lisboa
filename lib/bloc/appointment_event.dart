abstract class AppointmentEvent {}

class AppointmentFetchAll extends AppointmentEvent {}

class AppointmentInsert extends AppointmentEvent {
  Map<String, Object> values;

  AppointmentInsert(this.values);
}
