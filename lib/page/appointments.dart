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
    return Scaffold(
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
          if (state is AppointmentFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AppointmentFetched) {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(8),
                        itemCount: state.appointments.length,
                        itemBuilder: (context, index) {
                          Appointment appointment = state.appointments[index];
                          return Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(12),
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
                                      "Data e hora: ${DateFormat('dd/MM/yyyy hh:mm').format(appointment.dateTime)}"),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
