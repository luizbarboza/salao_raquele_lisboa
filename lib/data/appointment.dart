import '../model/appointment.dart';
import 'provider.dart';

Future<List<Appointment>> fetchAppointment(
    [Map<String, Object>? criteria]) async {
  final data = (await fetchData(
    table: "agendamento",
    columns: "*, cliente(*), especialista(*, pessoa(*), especialidade(*))",
    criteria: criteria,
  ));
  return data.map(Appointment.fromMap).toList();
}

Future<List<Appointment>> fetchSpecialistAppointment(int id) async {
  final data = (await fetchData(
    table: "agendamento",
    columns:
        "*, cliente(*), especialista!inner(*, pessoa!inner(*), especialidade!inner(*))",
    criteria: {"especialista.pessoa.id": id},
  ));
  return data.map(Appointment.fromMap).toList();
}

Future<Appointment> insertAppointment(Map<String, Object> values) async {
  final data = (await insertData(
    table: "agendamento",
    values: values,
    select: true,
  ));
  return (await fetchAppointment({"id": data!["id"]}))[0];
}
