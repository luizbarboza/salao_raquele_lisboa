import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sala_raquele_lisboa/page/new_appointment.dart';
import '../bloc/appointment.dart';
import '../bloc/appointment_event.dart';
import '../bloc/appointment_state.dart';
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
    context.read<AppointmentBloc>().add(AppointmentFetch());
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
                text: "Agendado",
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
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Cliente: ${appointment.client.name}"),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                              "Especialidade: ${appointment.specialist.specialty.name}"),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                              "Especialista: ${appointment.specialist.person.name}"),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                              "Data e hora: ${DateFormat('dd/MM/yyyy HH:mm').format(appointment.dateTime)}"),
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
