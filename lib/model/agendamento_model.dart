class AgendamentoModel {
  final String id;
  final String cliente;
  final DateTime data;
  final String servico;

  AgendamentoModel({
    required this.id,
    required this.cliente,
    required this.data,
    required this.servico,
  });

  factory AgendamentoModel.fromMap(Map<String, dynamic> map) {
    return AgendamentoModel(
      id: map['id'],
      cliente: map['cliente'],
      data: DateTime.parse(map['data']),
      servico: map['servico'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': cliente,
      'data': data.toIso8601String(),
      'servico': servico,
    };
  }
}
