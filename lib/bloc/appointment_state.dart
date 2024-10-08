import '../model/appointment.dart';

abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentFetching extends AppointmentState {}

class AppointmentFetchedAll extends AppointmentState {
  final List<Appointment> appointments;

  AppointmentFetchedAll(this.appointments);
}

class AppointmentInserting extends AppointmentState {}

class AppointmentInserted extends AppointmentState {
  final Appointment appointment;

  AppointmentInserted(this.appointment);
}

class AppointmentError extends AppointmentState {
  final String message;

  AppointmentError(this.message);
}
