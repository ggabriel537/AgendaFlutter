import 'package:agenda_flutter/entidades/Contato.dart';
import 'package:flutter/material.dart';

class Repositoriocontato { //Repositório de contatos
  final List<Contato> contatos = [];

  void addContato(Contato c) {
    contatos.add(c);
    SnackBar(
        content: Text('Contato Adicionado!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green);
  }

  List<Contato> getContatos() {
    return contatos;
  }

  void atualizarContato(Contato novo, int local)
  {
    if (contatos.length<local)
      {
        SnackBar(
            content: Text('Objeto selecionado está fora do indice!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red);
      }else{
        contatos.elementAt(local).nome = novo.nome;
        contatos.elementAt(local).telefone = novo.telefone;
        contatos.elementAt(local).email = novo.email;
        SnackBar(
            content: Text('Contato atualizado!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green);
    }
  }

  void removerContato(Contato c)
  {
    contatos.remove(c);
    SnackBar(
        content: Text('Contato Removido!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green);
  }
}