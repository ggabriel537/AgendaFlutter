import 'package:agenda_flutter/Repositorios/RepositorioContato.dart';
import 'package:agenda_flutter/telas/SelecaoAlt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Cadastro.dart';
import 'CadastroLogin.dart';

class Principal extends StatelessWidget {
  final Repositoriocontato rc = Repositoriocontato();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  void logout(BuildContext context) async {
    await secureStorage.delete(key: 'login_token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => CadastroLogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cadastro(rc: rc),
                ),
              );
            },
            child: Text("Cadastro de Contato"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Selecaoalt(rc: rc),
                ),
              );
            },
            child: Text("Lista"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroLogin(),
                ),
              );
            },
            child: Text("Cadastro de Login"),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => logout(context),
                child: Text("Deslogar"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
