import 'package:agenda_flutter/entidades/Contato.dart';

class Repositoriocontato { //Repositório de contatos
  List<Contato> contatos = [];

  void addContato(Contato c) {
    contatos.add(c);
  }

  List<Contato> getContatos() {
    return contatos;
  }

  void atualizarContato(Contato novo, int local)
  {
    contatos.elementAt(local).nome = novo.nome;
    contatos.elementAt(local).telefone = novo.telefone;
    contatos.elementAt(local).email = novo.email;
  }

  void removerContato(Contato c) {
    contatos.remove(c);
  }
}