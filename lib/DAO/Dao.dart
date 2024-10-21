import 'package:agenda_flutter/DAO/ContatoDAO.dart';
import 'package:agenda_flutter/entidades/Contato.dart';
import 'package:agenda_flutter/outros/RepositorioContato.dart';


class Dao {
  ContatoDAO cd = ContatoDAO();
  Repositoriocontato rc = Repositoriocontato();
  Dao({required this.rc});
  @override
  Future<void> adicionar(Contato c) async {
    cd.adicionar(c);
  }

  @override
  Future<List<Contato>> get contatos => cd.contatos;

  void remover(Contato c) {
    cd.remover(c);
  }


   atualizar(Contato novo) {
      cd.atualizar(novo);

  }
}