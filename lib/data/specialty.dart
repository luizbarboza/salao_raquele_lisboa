import '../model/specialty.dart';
import 'provider.dart';

Future<List<Specialty>> fetchAllSpecialties() async {
  return (await fetchData(table: "especialidade"))
      .map(Specialty.fromMap)
      .toList();
}
