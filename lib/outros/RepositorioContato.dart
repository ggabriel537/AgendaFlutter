import 'package:agenda_flutter/DAO/ContatoDAO.dart';
import 'package:agenda_flutter/entidades/Contato.dart';

import '../DAO/Dao.dart';

class Repositoriocontato { //Repositório de contatos
  List<Contato> contatos = [];
  ContatoDAO cd = ContatoDAO();
  void addContato(Contato c) {
    contatos.add(c);
    cd.adicionar(c);
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