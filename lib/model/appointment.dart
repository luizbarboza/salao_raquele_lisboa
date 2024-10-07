class Appointment {
  final int id;
  final int client;
  final int specialist;
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
      client: map['cliente'],
      specialist: map['especialista'],
      dateTime: DateTime.parse(map['data_hora']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': client,
      'especialista': specialist,
      'data_hora': dateTime,
    };
  }
}
