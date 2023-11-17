class EnderecoModel {
  final int id;
  final String bairro;
  final String cep;
  final String cidade;
  final String complemento;
  final String estado;
  final String logradouro;
  final String numero;

  EnderecoModel({
    required this.id,
    required this.bairro,
    required this.cep,
    required this.cidade,
    required this.complemento,
    required this.estado,
    required this.logradouro,
    required this.numero,
  });
}
