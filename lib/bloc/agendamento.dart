import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/agendamento_model.dart';
import 'agendamento_event.dart';
import 'agendamento_state.dart';

class AgendamentoBloc extends Bloc<AgendamentoEvent, AgendamentoState> {
  AgendamentoBloc() : super(AgendamentoInitial()) {
    on<FetchAgendamentos>(_onFetchAgendamentos);
    on<CreateAgendamento>(_onCreateAgendamento);
  }

  Future<void> _onFetchAgendamentos(
      FetchAgendamentos event, Emitter<AgendamentoState> emit) async {
    emit(AgendamentoLoading());
    try {
      final data = await Supabase.instance.client.from('agendamentos').select();

      final agendamentos =
          (data).map((map) => AgendamentoModel.fromMap(map)).toList();
      emit(AgendamentoLoaded(agendamentos));
    } catch (e) {
      emit(AgendamentoError(e.toString()));
    }
  }

  Future<void> _onCreateAgendamento(
      CreateAgendamento event, Emitter<AgendamentoState> emit) async {
    emit(AgendamentoLoading());
    try {
      await Supabase.instance.client.from('agendamentos').insert({
        'cliente': event.cliente,
        'data': event.data.toIso8601String(),
        'servico': event.servico,
      });

      add(FetchAgendamentos()); // Atualiza a lista
    } catch (e) {
      emit(AgendamentoError(e.toString()));
    }
  }
}
