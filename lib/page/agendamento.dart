import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/agendamento.dart';
import '../bloc/agendamento_event.dart';
import '../bloc/agendamento_state.dart';
import '../model/agendamento_model.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  AgendamentoPageState createState() => AgendamentoPageState();
}

class AgendamentoPageState extends State<AgendamentoPage> {
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _servicoController = TextEditingController();
  DateTime? _dataSelecionada;

  @override
  void initState() {
    super.initState();
    context.read<AgendamentoBloc>().add(FetchAgendamentos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
      ),
      body: BlocConsumer<AgendamentoBloc, AgendamentoState>(
        listener: (context, state) {
          if (state is AgendamentoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AgendamentoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AgendamentoLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.agendamentos.length,
                    itemBuilder: (context, index) {
                      AgendamentoModel agendamento = state.agendamentos[index];
                      return ListTile(
                        title: Text(agendamento.cliente),
                        subtitle: Text(
                            '${agendamento.servico} - ${DateFormat('dd/MM/yyyy HH:mm').format(agendamento.data)}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _clienteController,
                        decoration: const InputDecoration(labelText: 'Cliente'),
                      ),
                      TextField(
                        controller: _servicoController,
                        decoration: const InputDecoration(labelText: 'Serviço'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final data = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          if (data != null) {
                            final hora = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (hora != null) {
                              setState(() {
                                _dataSelecionada = DateTime(
                                  data.year,
                                  data.month,
                                  data.day,
                                  hora.hour,
                                  hora.minute,
                                );
                              });
                            }
                          }
                        },
                        child: const Text('Selecionar Data'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_clienteController.text.isNotEmpty &&
                              _servicoController.text.isNotEmpty &&
                              _dataSelecionada != null) {
                            context.read<AgendamentoBloc>().add(
                                  CreateAgendamento(
                                    _clienteController.text,
                                    _dataSelecionada!,
                                    _servicoController.text,
                                  ),
                                );
                          }
                        },
                        child: const Text('Agendar'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
