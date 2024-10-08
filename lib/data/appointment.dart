import '../model/appointment.dart';
import 'provider.dart';

Future<List<Appointment>> fetchAllAppointments() async {
  return (await fetchData(table: "agendamento"))
      .map(Appointment.fromMap)
      .toList();
}

Future<Appointment> insertAppointment(Map<String, Object> values) async {
  final data = (await insertData(
    table: "agendamento",
    values: values,
    select: true,
  ));
  return Appointment.fromMap(data!);
}
