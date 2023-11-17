import 'package:crediario/app/data/http/exceptions.dart';
import 'package:crediario/app/data/models/client_model.dart';
import 'package:crediario/app/data/repositories/client_repository.dart';
import 'package:flutter/material.dart';

class ClientsStore {
  final IClientRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ClientModel>> state =
      ValueNotifier<List<ClientModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ClientsStore({required this.repository});

  Future getClientes() async {
    isLoading.value = true;

    try {
      final result = await repository.getClient();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
