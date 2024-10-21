import '../model/specialty.dart';
import 'provider.dart';

Future<List<Specialty>> fetchSpecialty() async {
  return (await fetchData(table: "especialidade"))
      .map(Specialty.fromMap)
      .toList();
}

Future<Specialty> insertSpecialty(Map<String, Object> values) async {
  final data = (await insertData(
    table: "especialidade",
    values: values,
    select: true,
  ));
  return Specialty.fromMap(data!);
}

Future<void> deleteSpecialty(int id) async {
  (await deleteData(
    table: "especialidade",
    criteria: {"id": id},
  ));
}
