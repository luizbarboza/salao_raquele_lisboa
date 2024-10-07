import '../model/specialist.dart';
import 'provider.dart';

Future<List<Specialist>> fetchSpecialist(
    [Map<String, Object>? criteria]) async {
  final data = (await fetchData(
      table: "especialista", columns: "*, especialidade(*), pessoa(*)"));
  return data.map(Specialist.fromMap).toList();
}
