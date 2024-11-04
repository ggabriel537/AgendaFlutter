import 'package:agenda_flutter/telas/Principal.dart';
import 'package:flutter/material.dart';
import '../DAO/LoginDAO.dart';
import '../telas/CadastroLogin.dart';
import '../telas/LoginUsuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LoginDAO loginDAO = LoginDAO();
  bool usuarioCadastrado = await loginDAO.checarPrimeiroLogin(); // Verifica se há usuários cadastrados
  bool usuarioLogado = await loginDAO.verificarToken(); // Verifica se o token está salvo

  runApp(MyApp(
    usuarioCadastrado: usuarioCadastrado,
    usuarioLogado: usuarioLogado,
  ));
}

class MyApp extends StatelessWidget {
  final bool usuarioCadastrado;
  final bool usuarioLogado;

  MyApp({required this.usuarioCadastrado, required this.usuarioLogado});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: usuarioLogado
          ? Principal() // Tela inicial quando o usuário está logado
          : (usuarioCadastrado ? LoginUsuario() : CadastroLogin()), // Login ou cadastro
    );
  }
}
