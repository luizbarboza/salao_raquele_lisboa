import '../model/specialist.dart';
import 'provider.dart';

Future<List<Specialist>> fetchSpecialist(
    [Map<String, Object>? criteria]) async {
  final data = (await fetchData(
    table: "especialista",
    columns: "*, especialidade(*), pessoa(*)",
    criteria: criteria,
  ));
  return data.map(Specialist.fromMap).toList();
}

Future<Specialist> insertSpecialist(Map<String, Object> values) async {
  final data = (await insertData(
    table: "especialista",
    values: values,
    select: true,
  ));
  return (await fetchSpecialist({"id": data!["id"]}))[0];
}
