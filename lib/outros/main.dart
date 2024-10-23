import 'package:agenda_flutter/DAO/LoginDAO.dart';
import 'package:agenda_flutter/telas/CadastroLogin.dart';
import 'package:flutter/material.dart';

import '../telas/LoginUsuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LoginDAO loginDAO = LoginDAO();
  bool usuarioCadastrado = await loginDAO.checarPrimeiroLogin(); //Checa se ja existe usuarios cadastrados
  runApp(MyApp(usuarioCadastrado: usuarioCadastrado));
}

class MyApp extends StatelessWidget {
  final bool usuarioCadastrado;

  MyApp({required this.usuarioCadastrado});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: usuarioCadastrado ? LoginUsuario() : CadastroLogin(), //Caso ja existir leva para o LoginUsuario, senao leva para CadastroLogin
    );
  }
}
