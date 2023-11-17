import 'package:crediario/app/data/models/endereco_model.dart';
import 'package:crediario/app/data/models/pagamento_model.dart';

class ClientModel {
  final int id;
  final String cpf;
  final String? dataCadastro;
  final String nome;
  final String rg;
  final bool? status;
  final String telefone;
  final String vendedor;
  final EnderecoModel endereco;
  final PagamentoModel pagamento;

  ClientModel({
    required this.id,
    required this.cpf,
    this.dataCadastro,
    required this.nome,
    required this.rg,
    this.status,
    required this.telefone,
    required this.vendedor,
    required this.endereco,
    required this.pagamento,
  });

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    var enderecoData = map['endereco'];
    var pagamentoData = map['pagamento'];

    return ClientModel(
      id: map['id'],
      cpf: map['cpf'],
      dataCadastro: map['dataCadastro'],
      nome: map['nome'],
      rg: map['rg'],
      status: map['status'],
      telefone: map['telefone'],
      vendedor: map['vendedor'],
      endereco: EnderecoModel(
        id: enderecoData['id'],
        bairro: enderecoData['bairro'],
        cep: enderecoData['cep'],
        cidade: enderecoData['cidade'],
        complemento: enderecoData['complemento'],
        estado: enderecoData['estado'],
        logradouro: enderecoData['logradouro'],
        numero: enderecoData['numero'],
      ),
      pagamento: PagamentoModel(
        id: pagamentoData['id'],
        dataProximo: pagamentoData['dataProximo'],
        dataVenda: pagamentoData['dataVenda'],
        entrada: pagamentoData['entrada'],
        formaPagamento: pagamentoData['formaPagamento'],
        restante: pagamentoData['restante'],
        tipoPagamento: pagamentoData['tipoPagamento'],
        total: pagamentoData['total'],
        totalPago: pagamentoData['totalPago'],
      ),
    );
  }
}
