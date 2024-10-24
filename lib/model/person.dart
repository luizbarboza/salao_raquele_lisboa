class Person {
  final int id;
  final String name;
  final String cpf;
  final DateTime birthDate;
  final String phoneNumber;
  final String role;
  final String avatar;

  Person({
    required this.id,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.phoneNumber,
    required this.role,
    required this.avatar,
  });

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      name: map['nome'],
      cpf: map['cpf'],
      birthDate: DateTime.parse(map['data_nascimento']),
      phoneNumber: map['numero_telefone'],
      role: map["posicao"],
      avatar: map["avatar"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'cpf': cpf,
      'data_nascimento': birthDate,
      'numero_telefone': phoneNumber,
      'posicao': role,
      'avatar': avatar,
    };
  }
}
