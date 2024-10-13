import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/specialty.dart';
import 'specialty_event.dart';
import 'specialty_state.dart';

class SpecialtyBloc extends Bloc<SpecialtyEvent, SpecialtyState> {
  SpecialtyBloc() : super(SpecialtyInitial()) {
    on<SpecialtyFetch>(_onSpecialtyFetch);
    on<SpecialtyInsert>(_onSpecialtyInsert);
  }

  Future<void> _onSpecialtyFetch(
      SpecialtyFetch event, Emitter<SpecialtyState> emit) async {
    try {
      final specialty = await fetchSpecialty();
      emit(SpecialtyFetched(specialty));
    } catch (e) {
      emit(SpecialtyError(e.toString()));
    }
  }

  Future<void> _onSpecialtyInsert(
      SpecialtyInsert event, Emitter<SpecialtyState> emit) async {
    emit(SpecialtyInserting());
    try {
      final appointment = await insertSpecialty(event.values);
      emit(SpecialtyInserted(appointment));
    } catch (e) {
      emit(SpecialtyError(e.toString()));
    }
  }
}
