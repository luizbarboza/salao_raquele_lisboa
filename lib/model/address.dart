class Address {
  final int id;
  final String cep;
  final String federativeUnit;
  final String municipality;
  final String neighborhood;
  final String publicPlace;
  final String number;
  final String complement;

  Address({
    required this.id,
    required this.cep,
    required this.federativeUnit,
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
      federativeUnit: map['unidade_federativa'],
      municipality: map['municipio'],
      neighborhood: map['bairro'],
      publicPlace: map['logradouro'],
      number: map['numero'],
      complement: map['complemento'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cep': cep,
      'unidade_federativa': federativeUnit,
      'municipio': municipality,
      'bairro': neighborhood,
      'logradouro': publicPlace,
      'numero': number,
      'complemento': complement,
    };
  }
}
