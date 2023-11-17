// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable

import 'package:crediario/app/data/models/client_model.dart';
import 'package:crediario/app/data/models/endereco_model.dart';
import 'package:crediario/app/data/models/pagamento_model.dart';
import 'package:crediario/app/pages/home/clients/clients.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  UserForm(ClientsStore clients, {Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(ClientModel? client) {
    if (client != null) {
      _formData['id'] = client.id as String;
      _formData['nome'] = client.nome;
      _formData['CPF'] = client.cpf;
      _formData['RG'] = client.rg;
      _formData['telefone'] = client.telefone;
      _formData['vendedor'] = client.vendedor;
      _formData['cep'] = client.endereco.cep;
      _formData['logradouro'] = client.endereco.logradouro;
      _formData['numero'] = client.endereco.numero;
      _formData['bairro'] = client.endereco.bairro;
      _formData['cidade'] = client.endereco.cidade;
      _formData['UF'] = client.endereco.estado;
      _formData['complemento'] = client.endereco.complemento;
      _formData['proxPag'] = client.pagamento.dataProximo;
      _formData['entrada'] = client.pagamento.entrada.toString();
      _formData['formPag'] = client.pagamento.formaPagamento;
      _formData['tipoPag'] = client.pagamento.tipoPagamento;
      _formData['total'] = client.pagamento.total.toString();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // final user = ModalRoute.of(context)!.settings.arguments as ClientModel;
    // _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Formulario de cliente'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();
                ClientModel(
                  id: int.parse(_formData['id']!),
                  nome: _formData['nome'].toString(),
                  cpf: _formData['CPF'].toString(),
                  rg: _formData['RG'].toString(),
                  telefone: _formData['telefone'].toString(),
                  vendedor: _formData['vendedor'].toString(),
                  endereco: EnderecoModel(
                      id: int.parse(_formData['id']!),
                      cep: _formData['cep'].toString(),
                      logradouro: _formData['logradouro'].toString(),
                      numero: _formData['numero'].toString(),
                      bairro: _formData['bairro'].toString(),
                      cidade: _formData['cidade'].toString(),
                      estado: _formData['UF'].toString(),
                      complemento: _formData['complemento'].toString()),
                  pagamento: PagamentoModel(
                    id: int.parse(_formData['id']!),
                    dataProximo: _formData['proxPag'].toString(),
                    entrada: double.parse(_formData['entrada'].toString()),
                    formaPagamento: _formData['formPag'].toString(),
                    tipoPagamento: _formData['tipoPag'].toString(),
                    total: double.parse(_formData['total'].toString()),
                  ),
                );
              }

              Navigator.of(context).pop();
            },
            icon: Icon(Icons.save),
            color: Colors.white,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Form(
                child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nome inválido';
                    }
                  },
                  onSaved: (value) => _formData['nome'] = value!,
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
