import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/appointment.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<AppointmentFetchAll>(_onAppointmentFetchAll);
  }

  Future<void> _onAppointmentFetchAll(
      AppointmentFetchAll event, Emitter<AppointmentState> emit) async {
    try {
      final appointments = await fetchAllAppointments();
      emit(AppointmentFetchedAll(appointments));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }
}
