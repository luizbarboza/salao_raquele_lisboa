import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/person.dart';
import 'person_event.dart';
import 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonInitial()) {
    on<PersonFetch>(_onPersonFetch);
  }

  Future<void> _onPersonFetch(
      PersonFetch event, Emitter<PersonState> emit) async {
    try {
      final person = await fetchPerson(event.criteria);
      emit(PersonFetched(person));
    } catch (e) {
      emit(PersonError(e.toString()));
    }
  }
}
