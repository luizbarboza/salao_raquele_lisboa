class Address {
  final int id;
  final String cep;
  final String state;
  final String municipality;
  final String neighborhood;
  final String publicPlace;
  final String number;
  final String complement;

  Address({
    required this.id,
    required this.cep,
    required this.state,
    required this.municipality,
    required this.neighborhood,
    required this.publicPlace,
    required this.number,
    required this.complement,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'],
      cep: map['cep'],
      state: map['state'],
      municipality: map['municipality'],
      neighborhood: map['neighborhood'],
      publicPlace: map['publicPlace'],
      number: map['number'],
      complement: map['complement'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cep': cep,
      'estado': state,
      'municipio': municipality,
      'bairro': neighborhood,
      'logradouro': publicPlace,
      'numero': number,
      'complemento': complement,
    };
  }
}
