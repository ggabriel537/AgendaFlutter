import 'package:agenda_flutter/entidades/Contato.dart';
import 'package:flutter/material.dart';

import '../outros/RepositorioContato.dart';

class Listagem extends StatefulWidget { //Tela de listagem
  final Repositoriocontato rc;
  Listagem({required this.rc});

  @override
  State<Listagem> createState() => ListagemState(rc: rc);
}

class ListagemState extends State<Listagem> {
  final Repositoriocontato rc;

  ListagemState({required this.rc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de Contatos'),
      ),
      body: ListView.builder(
        itemCount: rc.getContatos().length,
        itemBuilder: (context, index) {
          Contato c = rc.getContatos()[index];
          return ListTile(
            title: Text(c.nome),
            subtitle: Text("- Telefone: "+c.telefone+"\n- Email: "+c.email),
          );
        },
      ),
    );
  }
}