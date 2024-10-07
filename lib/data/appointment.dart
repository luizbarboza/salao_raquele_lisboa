import '../model/appointment.dart';
import 'provider.dart';

Future<List<Appointment>> fetchAllAppointments() async {
  return (await fetchData(table: "agendamento"))
      .map(Appointment.fromMap)
      .toList();
}
