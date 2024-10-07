import 'person.dart';
import 'specialty.dart';

class Specialist {
  final int id;
  final Person person;
  final Specialty specialty;

  Specialist({
    required this.id,
    required this.person,
    required this.specialty,
  });

  factory Specialist.fromMap(Map<String, dynamic> map) {
    return Specialist(
      id: map['id'],
      person: Person.fromMap(map['pessoa']),
      specialty: Specialty.fromMap(map['especialidade']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pessoa': person.toMap(),
      'especialidade': specialty.toMap(),
    };
  }
}
