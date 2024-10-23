import 'package:agenda_flutter/Repositorios/RepositorioContato.dart';
import 'package:agenda_flutter/telas/SelecaoAlt.dart';
import 'package:flutter/material.dart';
import 'Cadastro.dart';
import 'CadastroLogin.dart';

class Principal extends StatelessWidget {
  Repositoriocontato rc = Repositoriocontato();

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
        ],
      ),
    );
  }
}
