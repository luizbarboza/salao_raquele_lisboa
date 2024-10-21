abstract class AppointmentEvent {}

class AppointmentFetch extends AppointmentEvent {
  final Map<String, Object>? criteria;

  AppointmentFetch([this.criteria]);
}

class AppointmentFetchSpecialist extends AppointmentEvent {
  final int specialistPersonId;

  AppointmentFetchSpecialist(this.specialistPersonId);
}

class AppointmentInsert extends AppointmentEvent {
  Map<String, Object> values;

  AppointmentInsert(this.values);
}

class AppointmentDelete extends AppointmentEvent {
  int id;

  AppointmentDelete(this.id);
}
