import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sala_raquele_lisboa/bloc/appointment_event.dart';
import 'package:sala_raquele_lisboa/bloc/specialty_event.dart';
import '../bloc/appointment.dart';
import '../bloc/appointment_state.dart';
import '../bloc/auth.dart';
import '../bloc/auth_state.dart';
import '../bloc/specialist.dart';
import '../bloc/specialist_event.dart';
import '../bloc/specialist_state.dart';
import '../bloc/specialty.dart';
import '../bloc/specialty_state.dart';

class NewAppointmentPage extends StatefulWidget {
  const NewAppointmentPage({super.key});

  @override
  NewAppointmentPageState createState() => NewAppointmentPageState();
}

class NewAppointmentPageState extends State<NewAppointmentPage> {
  //TextEditingController _specialtyController = TextEditingController();
  int? _selectedSpecialty;
  //TextEditingController _specialistController = TextEditingController();
  int? _selectedSpecialist;
  DateTime? _pickedDateTime;
  TextEditingController _dateTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Seleciona a hora
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // Combina data e hora
        DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          // Atualiza o controlador com a data e hora selecionada
          _pickedDateTime = fullDateTime;
          _dateTimeController.text =
              "${fullDateTime.day}/${fullDateTime.month}/${fullDateTime.year} ${pickedTime.format(context)}";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SpecialtyBloc>(
          create: (context) => SpecialtyBloc()..add(SpecialtyFetchAll()),
        ),
        BlocProvider<SpecialistBloc>(
          create: (context) => SpecialistBloc(),
        ),
        BlocProvider<AppointmentBloc>(
          create: (context) => AppointmentBloc(),
        ),
      ],
      child: BlocListener<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentInserted) {
            Navigator.pop(context);
            print("test");
          } else if (state is AppointmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  BlocBuilder<SpecialtyBloc, SpecialtyState>(
                      builder: (context, state) {
                    var dropdownMenuEntries = <DropdownMenuEntry<int?>>[];
                    if (state is SpecialtyFetchedAll) {
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
                          context.read<SpecialistBloc>().add(SpecialistFetch({
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
                      dropdownMenuEntries = state.specialist
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
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      readOnly:
                          true, // O campo não será editável diretamente, apenas via DatePicker
                      onTap: () => _selectDate(
                          context), // Abre o DatePicker ao tocar no campo
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    return FilledButton(
                      onPressed: () {
                        final auth = context.read<AuthBloc>();
                        final authState = auth.state;
                        if (authState is AuthAuthenticated) {
                          final appointment = context.read<AppointmentBloc>();
                          appointment.add(AppointmentInsert({
                            "cliente": authState.person.id,
                            "especialista": _selectedSpecialist!,
                            "data_hora": DateFormat('yyyy-MM-dd hh:mm:ss')
                                .format(_pickedDateTime!),
                          }));
                        }
                      },
                      child: const Text('Agendar'),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}