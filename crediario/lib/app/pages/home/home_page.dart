// ignore_for_file: prefer_const_constructors

import 'package:crediario/app/data/http/http_client.dart';
import 'package:crediario/app/data/repositories/client_repository.dart';
import 'package:crediario/app/pages/home/clients/clients.dart';
import 'package:crediario/app/pages/views/user_form.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ClientsStore clients = ClientsStore(
    repository: ClientRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    clients.getClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Lista de clientes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              clients.getClientes();
            },
            icon: Icon(Icons.replay_outlined),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => UserForm(clients)));
            },
            icon: Icon(Icons.add),
            color: Colors.white,
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          clients.isLoading,
          clients.erro,
          clients.state,
        ]),
        builder: (context, child) {
          if (clients.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (clients.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                clients.erro.value,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (clients.state.value.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum cliente cadastrado',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 32,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: clients.state.value.length,
              itemBuilder: (_, index) {
                final item = clients.state.value[index];
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.nome,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.endereco.logradouro} ${item.endereco.numero} ${item.endereco.complemento} ${item.endereco.bairro}',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 20,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Proximo pagamento: ${item.pagamento.dataProximo} Restante: ${item.pagamento.restante} Total: ${item.pagamento.total}',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 20,
                          ),
                        ],
                      ),
                      // trailing: Container(
                      //   width: 145,
                      //   child: Row(
                      //     children: <Widget>[
                      //       IconButton(
                      //         onPressed: () {
                      //           // Navigator.of(context).pushNamed(
                      //           //   AppRoutes.USER_FORM,
                      //           //   arguments: user,
                      //           // );
                      //         },
                      //         icon: Icon(Icons.edit),
                      //         color: Colors.orange,
                      //       ),
                      //       IconButton(
                      //         onPressed: () {
                      //           // Navigator.of(context).pushNamed(
                      //           //   AppRoutes.PAGAMENTO_FORM,
                      //           //   arguments: user,
                      //           // );
                      //         },
                      //         icon: Icon(Icons.attach_money),
                      //         color: Colors.green,
                      //       ),
                      //       IconButton(
                      //         onPressed: () {
                      //           // Navigator.of(context).pushNamed(
                      //           //   AppRoutes.NOVA_COMPRA,
                      //           //   arguments: user,
                      //           // );
                      //         },
                      //         icon: Icon(Icons.shopping_cart),
                      //         color: Colors.greenAccent,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
