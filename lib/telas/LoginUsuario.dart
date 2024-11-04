import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../DAO/LoginDAO.dart';
import '../entidades/Login.dart';
import 'CadastroLogin.dart';
import 'Principal.dart';

class LoginUsuario extends StatefulWidget {
  @override
  State<LoginUsuario> createState() => _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

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

  Future<void> _realizarLogin(Login login) async {
    LoginDAO loginDAO = LoginDAO();
    bool usuarioValido = await loginDAO.verificarUsuario(login);

    if (usuarioValido) {
      await secureStorage.write(key: 'login_token', value: 'token_de_login');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login realizado com sucesso!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Principal()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário ou senha inválidos!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _validarCampos();
                if (!erroUser && !erroSenha) {
                  Login login = Login(
                    user: userController.text,
                    senha: senhaController.text,
                  );
                  await _realizarLogin(login);
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroLogin(),
                  ),
                );
              },
              child: Text("Cadastro de Login"),
            ),
          ],
        ),
      ),
    );
  }
}
