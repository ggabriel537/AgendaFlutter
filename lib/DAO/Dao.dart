import 'package:agenda_flutter/DAO/ContatoDAO.dart';
import 'package:agenda_flutter/entidades/Contato.dart';
import 'package:agenda_flutter/outros/RepositorioContato.dart';

import 'InterfaceDao.dart';

class Dao implements InterfaceDao {
  Repositoriocontato rc = Repositoriocontato();
  ContatoDAO cd = ContatoDAO();

  Dao({required this.rc});

  @override
  Future<void> adicionar(Contato c) async {
    rc.addContato(c);
    cd.adicionar(c);
  }

  @override
  Future<List<Contato>> get contatos => cd.contatos;

  @override
  Future<int> remover(Contato c) {
    int i = rc.contatos.indexOf(c);
    if (i != -1)
      {
        rc.contatos.removeAt(i);
        cd.remover(Contato(id: c.id, nome: "", telefone: "", email: ""));
      }
    return Future.value(i);
  }

  @override
  Future<Contato> atualizar(Contato novo) {
    int i = rc.contatos.indexOf(novo);
    if (i != -1)
      {
        rc.contatos.removeAt(i);
        rc.contatos.insert(i, novo);
        cd.atualizar(novo);
      }
    return novo as Future<Contato>;
  }
}