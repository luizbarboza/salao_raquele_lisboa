import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/appointment.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<AppointmentFetch>(_onAppointmentFetch);
    on<AppointmentFetchSpecialist>(_onAppointmentFetchSpecialist);
    on<AppointmentInsert>(_onAppointmentInsert);
    on<AppointmentDelete>(_onAppointmentDelete);
  }

  Future<void> _onAppointmentFetch(
      AppointmentFetch event, Emitter<AppointmentState> emit) async {
    emit(AppointmentFetching());
    try {
      final appointment = await fetchAppointment(event.criteria);
      emit(AppointmentFetched(appointment));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> _onAppointmentFetchSpecialist(
      AppointmentFetchSpecialist event, Emitter<AppointmentState> emit) async {
    emit(AppointmentFetching());
    try {
      final appointment =
          await fetchSpecialistAppointment(event.specialistPersonId);
      emit(AppointmentFetched(appointment));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> _onAppointmentInsert(
      AppointmentInsert event, Emitter<AppointmentState> emit) async {
    emit(AppointmentInserting());
    try {
      final appointment = await insertAppointment(event.values);
      emit(AppointmentInserted(appointment));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> _onAppointmentDelete(
      AppointmentDelete event, Emitter<AppointmentState> emit) async {
    emit(AppointmentDeleting());
    try {
      await deleteAppointment(event.id);
      emit(AppointmentDeleted());
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }
}
