import 'package:equatable/equatable.dart';
import '../model/agendamento_model.dart';

abstract class AgendamentoState extends Equatable {
  @override
  List<Object> get props => [];
}

class AgendamentoInitial extends AgendamentoState {}

class AgendamentoLoading extends AgendamentoState {}

class AgendamentoLoaded extends AgendamentoState {
  final List<AgendamentoModel> agendamentos;

  AgendamentoLoaded(this.agendamentos);

  @override
  List<Object> get props => [agendamentos];
}

class AgendamentoError extends AgendamentoState {
  final String message;

  AgendamentoError(this.message);

  @override
  List<Object> get props => [message];
}
