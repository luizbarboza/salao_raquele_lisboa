import '../model/address.dart';
import 'provider.dart';

Future<List<Address>> fetchAddress([Map<String, Object>? criteria]) async {
  final data = (await fetchData(
    table: "endereco",
    criteria: criteria,
  ));
  return data.map(Address.fromMap).toList();
}

Future<Address> insertAddress(Map<String, Object> values) async {
  final data = (await insertData(
    table: "endereco",
    values: values,
    select: true,
  ));
  return Address.fromMap(data!);
}