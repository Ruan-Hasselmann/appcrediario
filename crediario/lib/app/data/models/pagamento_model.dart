class PagamentoModel {
  final int? id;
  final String dataProximo;
  final String? dataVenda;
  final double entrada;
  final String formaPagamento;
  final double? restante;
  final String tipoPagamento;
  final double total;
  final double? totalPago;

  PagamentoModel({
    this.id,
    required this.dataProximo,
    this.dataVenda,
    required this.entrada,
    required this.formaPagamento,
    this.restante,
    required this.tipoPagamento,
    required this.total,
    this.totalPago,
  });
}
