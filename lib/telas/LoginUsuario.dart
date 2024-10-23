import 'package:flutter/material.dart';
import '../DAO/LoginDAO.dart';
import '../entidades/Login.dart';
import 'Principal.dart';

class LoginUsuario extends StatefulWidget {
  @override
  State<LoginUsuario> createState() => _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  String userErro = "";
  String senhaErro = "";
  bool erroUser = false;
  bool erroSenha = false;

  void _validarCampos() {
    setState(() {
      erroUser = userController.text.isEmpty;
      userErro = erroUser ? "Usuário não pode estar em branco!" : '';
      erroSenha = senhaController.text.isEmpty;
      senhaErro = erroSenha ? "Senha não pode estar em branco!" : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginDAO loginDAO = LoginDAO();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Usuário',
                errorText: erroUser ? userErro : null,
              ),
              controller: userController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
                errorText: erroSenha ? senhaErro : null,
              ),
              controller: senhaController,
              obscureText: true, // Oculta a senha
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _validarCampos();
                if (!erroUser && !erroSenha) {
                  // Cria um objeto Login para verificar
                  Login login = Login(
                    user: userController.text,
                    senha: senhaController.text,
                  );

                  bool usuarioValido = await loginDAO.verificarUsuario(login);
                  if (usuarioValido) {
                    // Usuário autenticado com sucesso
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login realizado com sucesso!'),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Redireciona para a tela principal
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Principal()),
                    );
                  } else {
                    // Usuário ou senha inválidos
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Usuário ou senha inválidos!'),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, verifique os campos digitados.'),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
