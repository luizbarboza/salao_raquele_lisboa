import '../model/appointment.dart';
import '../model/person.dart';
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

Future<List<Appointment>> fetchSpecialistAppointment(
    int specialistPersonId) async {
  final data = (await fetchData(
    table: "agendamento",
    columns:
        "*, cliente(*), especialista!inner(*, pessoa!inner(*), especialidade!inner(*))",
    criteria: {"especialista.pessoa.id": specialistPersonId},
  ));
  return data.map(Appointment.fromMap).toList();
}

Future<List<Appointment>> fetchPersonAppointment(Person person) async {
  if (person.role == "administrador") {
    return fetchAppointment();
  } else if (person.role == "colaborador") {
    return fetchSpecialistAppointment(person.id);
  } else {
    return fetchAppointment({"cliente": person.id});
  }
}

Future<Appointment> insertAppointment(Map<String, Object> values) async {
  final data = (await insertData(
    table: "agendamento",
    values: values,
    select: true,
  ));
  return (await fetchAppointment({"id": data!["id"]}))[0];
}

Future<void> deleteAppointment(int id) async {
  (await deleteData(
    table: "agendamento",
    criteria: {"id": id},
  ));
}
