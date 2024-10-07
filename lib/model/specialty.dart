class Specialty {
  final int id;
  final String name;
  final String description;

  Specialty({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Specialty.fromMap(Map<String, dynamic> map) {
    return Specialty(
      id: map['id'],
      name: map['nome'],
      description: map['descricao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'descricao': description,
    };
  }
}
