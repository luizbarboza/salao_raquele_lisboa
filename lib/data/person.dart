import '../model/person.dart';
import 'provider.dart';

Future<List<Person>> fetchPerson([Map<String, Object>? criteria]) async {
  final data = (await fetchData(
    table: "pessoa",
    criteria: criteria,
  ));
  return data.map(Person.fromMap).toList();
}
