import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../entidades/Contato.dart';
import '../outros/RepositorioContato.dart';

class Cadastro extends StatefulWidget {
  final Repositoriocontato rc;
  Cadastro({required this.rc});

  @override
  State<Cadastro> createState() => _CadastroState(rc: rc);
}

class _CadastroState extends State<Cadastro> { //Tela de cadastro
  //Controllers para receber os dados do usuário
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final Repositoriocontato rc;

  _CadastroState({required this.rc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Contatos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [ //Campos da tela de cadastro
            TextField(
              decoration: InputDecoration(labelText: 'Nome'),
              controller: nomeController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Telefone'),
              controller: telefoneController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'E-mail'),
              controller: emailController,
            ),
            SizedBox(height: 20),
            ElevatedButton( //Botão para cadastrar
              onPressed: () {
                setState(() {
                  rc.addContato(Contato(
                    nome: nomeController.text,
                    telefone: telefoneController.text,
                    email: emailController.text,
                  ));
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Contato ' + nomeController.text + ' cadastrado com sucesso!'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}