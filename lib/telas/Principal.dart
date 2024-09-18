import 'package:flutter/material.dart';

import '../outros/RepositorioContato.dart';
import '../outros/main.dart';
import 'Cadastro.dart';
import 'Listagem.dart';

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
          ElevatedButton( //Botão para tela de listagem
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Listagem(rc: rc),
                ),
              );
            },
            child: Text("Listar"),
          ),
        ],
      ),
    );
  }
}