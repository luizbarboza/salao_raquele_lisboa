import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/specialist.dart';
import 'specialist_event.dart';
import 'specialist_state.dart';

class SpecialistBloc extends Bloc<SpecialistEvent, SpecialistState> {
  SpecialistBloc() : super(SpecialistInitial()) {
    on<SpecialistFetch>(_onSpecialistFetch);
    on<SpecialistInsert>(_onSpecialistInsert);
  }

  Future<void> _onSpecialistFetch(
      SpecialistFetch event, Emitter<SpecialistState> emit) async {
    emit(SpecialistFetching());
    try {
      final specialist = await fetchSpecialist(event.criteria);
      emit(SpecialistFetched(specialist));
    } catch (e) {
      emit(SpecialistError(e.toString()));
    }
  }

  Future<void> _onSpecialistInsert(
      SpecialistInsert event, Emitter<SpecialistState> emit) async {
    emit(SpecialistInserting());
    try {
      final specialist = await insertSpecialist(event.values);
      emit(SpecialistInserted(specialist));
    } catch (e) {
      emit(SpecialistError(e.toString()));
    }
  }
}
