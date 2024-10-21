import 'package:agenda_flutter/DAO/ContatoDAO.dart';
import 'package:agenda_flutter/DAO/Dao.dart';
import 'package:agenda_flutter/outros/RepositorioContato.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../entidades/Contato.dart';

class Cadastro extends StatefulWidget {
  Repositoriocontato rc = Repositoriocontato();
  Cadastro({required this.rc});

  @override
  State<Cadastro> createState() => _CadastroState(rc: rc);
}

class _CadastroState extends State<Cadastro> {
  Repositoriocontato rc = Repositoriocontato();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String telErro = "";
  String emailErro = "";
  bool erroTelefone = false;
  bool erroEmail = false;
  bool erroNome = false;
  String nomeErro = "";

  final MaskTextInputFormatter mascaraTel = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy,
  );

  _CadastroState({required this.rc});

  void _validarCampos() {
    setState(() {
      erroNome = nomeController.text.isEmpty;
      nomeErro = erroNome ? "Nome não pode estar em branco!" : '';
      erroTelefone = telefoneController.text.length != 16;
      telErro = erroTelefone ? "Telefone Inválido!" : '';
      erroEmail = !(emailController.text.contains("@") && emailController.text.contains("."));
      emailErro = erroEmail ? "E-mail Inválido!" : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Contatos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
                errorText: erroNome ? nomeErro : null,
              ),
              controller: nomeController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Telefone',
                errorText: erroTelefone ? telErro : null,
              ),
              controller: telefoneController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                mascaraTel,
              ],
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                errorText: erroEmail ? emailErro : null,
              ),
              controller: emailController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _validarCampos();
                if (!erroNome && !erroTelefone && !erroEmail) {
                  /*await rc.addContato(Contato(
                    nome: nomeController.text,
                    telefone: telefoneController.text,
                    email: emailController.text,
                  ));*/
                  rc.addContato(Contato(
                    nome: nomeController.text,
                    telefone: telefoneController.text,
                    email: emailController.text,
                  ));
                  Navigator.pop(context, true);
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
