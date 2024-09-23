import 'package:agenda_flutter/telas/SelecaoAlt.dart';
import 'package:flutter/material.dart';

import '../outros/RepositorioContato.dart';
import 'Cadastro.dart';

class Principal extends StatelessWidget { //Tela principal de navegação
  final Repositoriocontato rc = Repositoriocontato();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
      ),
      body: Column(
        children: [
          ElevatedButton( //Botão para tela de cadastro
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cadastro(rc: rc),
                ),
              );
            },
            child: Text("Cadastro"),
          ),
          ElevatedButton( //Botão para tela de edicao
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
        ],
      ),
    );
  }
}