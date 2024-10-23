import 'package:flutter/material.dart';
import '../DAO/LoginDAO.dart';
import '../entidades/Login.dart';
import 'Principal.dart';

class CadastroLogin extends StatefulWidget {
  @override
  State<CadastroLogin> createState() => _CadastroLoginState();
}

class _CadastroLoginState extends State<CadastroLogin> {
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
        title: Text('Cadastro de Login'),
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
                  // Verifica se o usuário já existe
                  bool usuarioExistente = await loginDAO.verificarUsuario(Login(
                    user: userController.text,
                    senha: senhaController.text,
                  ));

                  if (usuarioExistente) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Usuário já cadastrado!'),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Adiciona o novo usuário
                    await loginDAO.adicionarUsuario(Login(
                      user: userController.text,
                      senha: senhaController.text,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Cadastro realizado com sucesso!'),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Redireciona para a tela principal
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Principal()),
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
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
