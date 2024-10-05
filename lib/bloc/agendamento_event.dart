import 'package:equatable/equatable.dart';

abstract class AgendamentoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAgendamentos extends AgendamentoEvent {}

class CreateAgendamento extends AgendamentoEvent {
  final String cliente;
  final DateTime data;
  final String servico;

  CreateAgendamento(this.cliente, this.data, this.servico);

  @override
  List<Object> get props => [cliente, data, servico];
}
