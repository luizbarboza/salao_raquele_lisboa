import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../bloc/appointment.dart';
import '../bloc/appointment_event.dart';
import '../bloc/appointment_state.dart';
import '../bloc/auth.dart';
import '../bloc/auth_state.dart';
import '../bloc/specialist.dart';
import '../bloc/specialist_event.dart';
import '../bloc/specialist_state.dart';
import '../bloc/specialty.dart';
import '../bloc/specialty_event.dart';
import '../bloc/specialty_state.dart';

class NewAppointmentPage extends StatefulWidget {
  const NewAppointmentPage({super.key});

  @override
  NewAppointmentPageState createState() => NewAppointmentPageState();
}

class NewAppointmentPageState extends State<NewAppointmentPage> {
  int? _selectedSpecialty;
  int? _selectedSpecialist;
  DateTime? _pickedDateTime;
  TextEditingController _dateTimeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _pickedDateTime = fullDateTime;
          _dateTimeController.text =
              "${DateFormat('dd/MM/yyyy HH:mm').format(fullDateTime)}";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SpecialtyBloc>(
          create: (context) => SpecialtyBloc()..add(SpecialtyFetch()),
        ),
        BlocProvider<SpecialistBloc>(
          create: (context) => SpecialistBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Novo Agendamento'),
        ),
        body: BlocConsumer<AppointmentBloc, AppointmentState>(
          listener: (context, state) {
            if (state is AppointmentInserted) {
              context.read<AppointmentBloc>().add(
                    AppointmentPersonFetch(
                      (context.read<AuthBloc>().state as AuthAuthenticated)
                          .person,
                    ),
                  );
              Navigator.pop(context);
            } else if (state is AppointmentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is AppointmentInserting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Adicionando a imagem acima das caixas de seleção
                      SvgPicture.asset(
                        width: 250,
                        "assets/new_appointment_2.svg",
                      ),
                      const SizedBox(
                          height: 20), // Espaço entre imagem e seleções
                      BlocBuilder<SpecialtyBloc, SpecialtyState>(
                          builder: (context, state) {
                        var dropdownMenuEntries = <DropdownMenuEntry<int?>>[];
                        if (state is SpecialtyFetched) {
                          dropdownMenuEntries = state.specialties
                              .map((specialty) => DropdownMenuEntry(
                                    value: specialty.id,
                                    label: specialty.name,
                                  ))
                              .toList();
                        }
                        return DropdownMenu<int?>(
                          width: 300,
                          initialSelection: null,
                          label: const Text('Especialidade'),
                          onSelected: (selectedSpecialty) {
                            if (selectedSpecialty != null) {
                              context
                                  .read<SpecialistBloc>()
                                  .add(SpecialistFetch({
                                    "especialidade": selectedSpecialty,
                                  }));
                            }
                            setState(() {
                              _selectedSpecialty = selectedSpecialty;
                            });
                          },
                          dropdownMenuEntries: dropdownMenuEntries,
                        );
                      }),
                      const SizedBox(height: 20),
                      BlocBuilder<SpecialistBloc, SpecialistState>(
                          builder: (context, state) {
                        var dropdownMenuEntries = <DropdownMenuEntry<int?>>[];
                        if (_selectedSpecialty != null &&
                            state is SpecialistFetched) {
                          dropdownMenuEntries = state.specialists
                              .map((specialist) => DropdownMenuEntry(
                                    value: specialist.id,
                                    label: specialist.person.name,
                                  ))
                              .toList();
                        }
                        return DropdownMenu<int?>(
                          width: 300,
                          initialSelection: null,
                          label: const Text('Especialista'),
                          onSelected: (selectedSpecialist) {
                            setState(() {
                              _selectedSpecialist = selectedSpecialist;
                            });
                          },
                          dropdownMenuEntries: dropdownMenuEntries,
                        );
                      }),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _dateTimeController,
                          decoration: InputDecoration(
                            labelText: 'Data e hora',
                            suffixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          onTap: () => _selectDate(context),
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                        return FilledButton.icon(
                          icon: const Icon(Icons.schedule),
                          onPressed: () {
                            final auth = context.read<AuthBloc>();
                            final authState = auth.state;
                            if (authState is AuthAuthenticated) {
                              final appointment =
                                  context.read<AppointmentBloc>();
                              appointment.add(AppointmentInsert({
                                "cliente": authState.person.id,
                                "especialista": _selectedSpecialist!,
                                "data_hora": DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(_pickedDateTime!),
                              }));
                            }
                          },
                          label: const Text('Agendar'),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
