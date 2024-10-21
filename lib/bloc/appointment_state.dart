import '../model/appointment.dart';

abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentFetching extends AppointmentState {}

class AppointmentFetched extends AppointmentState {
  final List<Appointment> appointments;

  AppointmentFetched(this.appointments);
}

class AppointmentInserting extends AppointmentState {}

class AppointmentInserted extends AppointmentState {
  final Appointment appointment;

  AppointmentInserted(this.appointment);
}

class AppointmentDeleting extends AppointmentState {}

class AppointmentDeleted extends AppointmentState {}

class AppointmentError extends AppointmentState {
  final String message;

  AppointmentError(this.message);
}
