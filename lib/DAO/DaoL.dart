import '../entidades/Login.dart';
import 'LoginDAO.dart';


class DaoL {
  LoginDAO ld = LoginDAO();
  @override
  Future<void> adicionar(Login l) async {
    ld.adicionarUsuario(l);
  }

  @override
  Future<List<Login>> get logins => ld.logins;

  void remover(Login l) {
    ld.removerUsuario(l);
  }


  atualizar(Login l) {
    ld.atualizar(l);
  }
}