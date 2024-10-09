import '../model/appointment.dart';
import 'provider.dart';

Future<List<Appointment>> fetchAppointment() async {
  final data = (await fetchData(
    table: "agendamento",
    columns: "*, cliente(*), especialista(*, pessoa(*), especialidade(*))",
  ));
  print(data);
  return data.map(Appointment.fromMap).toList();
}

Future<Appointment> insertAppointment(Map<String, Object> values) async {
  final data = (await insertData(
    table: "agendamento",
    values: values,
    select: true,
  ));
  return Appointment.fromMap(data!);
}
