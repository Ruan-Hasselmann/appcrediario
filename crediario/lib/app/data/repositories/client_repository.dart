import 'dart:convert';

import 'package:crediario/app/data/http/exceptions.dart';
import 'package:crediario/app/data/http/http_client.dart';
import 'package:crediario/app/data/models/client_model.dart';

abstract class IClientRepository {
  Future<List<ClientModel>> getClient();
}

class ClientRepository implements IClientRepository {
  final IHttpClient client;
  ClientRepository({required this.client});

  @override
  Future<List<ClientModel>> getClient() async {
    final response = await client.get(
      url: 'https://octopus-app-8fgh4.ondigitalocean.app/clientes',
    );

    if (response.statusCode == 200) {
      final List<ClientModel> clientes = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final ClientModel cliente = ClientModel.fromMap(item);
        clientes.add(cliente);
      }).toList();

      return clientes;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é valida");
    } else {
      throw Exception('Não foi possivel carregar os dados');
    }
  }
}
