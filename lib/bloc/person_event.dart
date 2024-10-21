import 'dart:typed_data';

abstract class PersonEvent {}

class PersonFetch extends PersonEvent {
  final Map<String, Object>? criteria;

  PersonFetch([this.criteria]);
}

class PersonUpdateAvatar extends PersonEvent {
  final int id;
  final Uint8List data;

  PersonUpdateAvatar(
    this.id,
    this.data,
  );
}
