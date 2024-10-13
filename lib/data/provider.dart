import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Map<String, dynamic>>> fetchData({
  required String table,
  String? columns,
  Map<String, Object>? criteria,
}) async {
  var builder = Supabase.instance.client.from(table).select(columns ?? "*");

  criteria?.forEach((key, value) => builder = builder.eq(key, value));

  return await builder;
}

Future<Map<String, dynamic>?> insertData({
  required String table,
  required Map<String, Object> values,
  bool? select,
}) async {
  select ??= false;
  final builder = Supabase.instance.client.from(table).insert(values);
  if (select) return (await builder.select())[0];
  return await builder;
}

Future<List<Map<String, dynamic>>?> updateData({
  required String table,
  required Map<String, Object> values,
  Map<String, Object>? criteria,
  bool? select,
}) async {
  select ??= false;
  var builder = Supabase.instance.client.from(table).update(values);
  criteria?.forEach((key, value) => builder = builder.eq(key, value));
  if (select) return await builder.select();
  return await builder;
}

Future<List<Map<String, dynamic>>?> deleteData({
  required String table,
  required Map<String, Object> criteria,
  bool? select,
}) async {
  select ??= false;
  var builder = Supabase.instance.client.from(table).delete();
  criteria.forEach((key, value) => builder = builder.eq(key, value));
  if (select) return await builder.select();
  return await builder;
}
