import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/appointment.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<AppointmentFetch>(_onAppointmentFetch);
    on<AppointmentInsert>(_onAppointmentInsert);
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
}
