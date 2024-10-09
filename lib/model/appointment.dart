import 'person.dart';
import 'specialist.dart';

class Appointment {
  final int id;
  final Person client;
  final Specialist specialist;
  final DateTime dateTime;

  Appointment({
    required this.id,
    required this.client,
    required this.specialist,
    required this.dateTime,
  });

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      client: Person.fromMap(map['cliente']),
      specialist: Specialist.fromMap(map['especialista']),
      dateTime: DateTime.parse(map['data_hora']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': client.toMap(),
      'especialista': specialist.toMap(),
      'data_hora': dateTime,
    };
  }
}
