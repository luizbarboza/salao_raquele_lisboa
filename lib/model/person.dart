class Person {
  final int id;
  final String name;
  final String cpf;
  final DateTime birthDate;
  final String phoneNumber;
  final String address;
  final String role;

  Person({
    required this.id,
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.phoneNumber,
    required this.address,
    required this.role,
  });

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      name: map['nome'],
      cpf: map['cpf'],
      birthDate: DateTime.parse(map['data_nascimento']),
      phoneNumber: map['numero_telefone'],
      address: map['endereco'],
      role: map["posicao"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'cpf': cpf,
      'data_nascimento': birthDate,
      'numero_telefone': phoneNumber,
      'endereco': address,
      'posicao': role,
    };
  }
}
