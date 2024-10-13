import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sala_raquele_lisboa/page/new_appointment.dart';
import '../bloc/appointment.dart';
import '../bloc/appointment_event.dart';
import '../bloc/appointment_state.dart';
import '../bloc/auth.dart';
import '../bloc/auth_state.dart';
import '../model/appointment.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  AppointmentsPageState createState() => AppointmentsPageState();
}

class AppointmentsPageState extends State<AppointmentsPage> {
  @override
  void initState() {
    super.initState();
    final person = (context.read<AuthBloc>().state as AuthAuthenticated).person;
    final appointmentsBloc = context.read<AppointmentBloc>();
    if (person.role == "cliente") {
      appointmentsBloc.add(AppointmentFetch({"cliente": person.id}));
    } else if (person.role == "colaborador") {
      appointmentsBloc.add(AppointmentFetchSpecialist(person.id));
    } else if (person.role == "administrador") {
      appointmentsBloc.add(AppointmentFetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agendamentos'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Próximos",
                icon: Icon(Icons.schedule),
              ),
              Tab(
                text: "Histórico",
                icon: Icon(Icons.history),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const NewAppointmentPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<AppointmentBloc, AppointmentState>(
          listener: (context, state) {
            if (state is AppointmentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            List<Widget> children;
            if (state is AppointmentFetching) {
              children = List.generate(
                2,
                (_) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is AppointmentFetched) {
              final appointments = state.appointments;
              final now = DateTime.now();
              children = [
                AppointmentsLisView(
                  appointments.where((a) => a.dateTime.isAfter(now)).toList(),
                ),
                AppointmentsLisView(
                  appointments.where((a) => a.dateTime.isBefore(now)).toList(),
                )
              ];
            } else {
              children = List.generate(
                2,
                (_) => Container(),
              );
            }
            return TabBarView(children: children);
          },
        ),
      ),
    );
  }
}

class AppointmentsLisView extends StatelessWidget {
  final List<Appointment> appointments;

  const AppointmentsLisView(this.appointments, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  Appointment appointment = appointments[index];
                  return Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                    child: Icon(Symbols.person, size: 20)),
                                TextSpan(text: " ${appointment.client.name}"),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                    child: Icon(Symbols.license, size: 20)),
                                TextSpan(
                                    text:
                                        " ${appointment.specialist.specialty.name}"),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                    child:
                                        Icon(Symbols.person_apron, size: 20)),
                                TextSpan(
                                    text:
                                        " ${appointment.specialist.person.name}"),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Symbols.schedule, size: 20),
                                ),
                                TextSpan(
                                    text:
                                        " ${DateFormat('dd/MM/yyyy HH:mm').format(appointment.dateTime)}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
