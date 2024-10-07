import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/specialty.dart';
import 'specialty_event.dart';
import 'specialty_state.dart';

class SpecialtyBloc extends Bloc<SpecialtyEvent, SpecialtyState> {
  SpecialtyBloc() : super(SpecialtyInitial()) {
    on<SpecialtyFetchAll>(_onSpecialtyFetchAll);
  }

  Future<void> _onSpecialtyFetchAll(
      SpecialtyFetchAll event, Emitter<SpecialtyState> emit) async {
    try {
      final specialtys = await fetchAllSpecialties();
      emit(SpecialtyFetchedAll(specialtys));
    } catch (e) {
      emit(SpecialtyError(e.toString()));
    }
  }
}
