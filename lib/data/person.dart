import 'dart:typed_data';

import '../model/person.dart';
import 'provider.dart';

Future<List<Person>> fetchPerson([Map<String, Object>? criteria]) async {
  final data = (await fetchData(
    table: "pessoa",
    criteria: criteria,
  ));
  return data.map(Person.fromMap).toList();
}

Future<Person> insertPerson(Map<String, Object> values) async {
  final data = (await insertData(
    table: "pessoa",
    values: values,
    select: true,
  ));
  return Person.fromMap(data!);
}

Future<Person> updateAvatar(int id, Uint8List data) async {
  final url = await uploadData("public/$id", data);
  final people = (await updateData(
    table: "pessoa",
    values: {"avatar": url},
    criteria: {"id": id},
    select: true,
  ));
  return Person.fromMap(people![0]);
}

Future<Person> makeCollaborator(int id) async {
  final data = (await updateData(
    table: "pessoa",
    values: {"posicao": "colaborador"},
    criteria: {"id": id},
    select: true,
  ));
  return Person.fromMap(data![0]);
}
