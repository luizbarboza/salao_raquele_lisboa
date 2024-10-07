import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    context.read<AppointmentBloc>().add(AppointmentFetchAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_appointment');
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
          } else if (state is AppointmentFetchedAll) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.appointments.length,
                    itemBuilder: (context, index) {
                      Appointment appointment = state.appointments[index];
                      return ListTile(
                        title: Text(appointment.client.toString()),
                        subtitle: Text(appointment.specialist.toString()),
                      );
                    },
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
