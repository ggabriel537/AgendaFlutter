import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  String telErro = "";
  String emailErro = "";
  bool erroTelefone = false;
  bool erroEmail = false;
  bool erroNome = false;
  String nomeErro = "";
  final Repositoriocontato rc;
  final MaskTextInputFormatter mascaraTel = new MaskTextInputFormatter( //Mascara para telefone
      mask: '(##) # ####-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  _CadastroState({required this.rc});

  void _validarCampos() {
    setState(() {
      // Verifica se o nome está vazio
      erroNome = nomeController.text.isEmpty;
      nomeErro = erroNome ? "Nome não pode estar em branco!" : '';

      // Verifica se o telefone possui 16 dígitos
      erroTelefone = telefoneController.text.length != 16;
      telErro = erroTelefone ? "Telefone Inválido!" : '';

      // Valida o e-mail
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
          children: [ //Campos da tela de cadastro
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
                errorText: erroNome ? nomeErro : null, // Caso estiver errado, preenche com a mensagem de erro
              ),
              controller: nomeController,
              onChanged: (value) {
                setState(() {
                  // Testa para verificar se o nome está vazio
                  if (nomeController.text.isEmpty) {
                    erroNome = true;
                    nomeErro = "Nome não pode estar em branco!";
                  } else {
                    erroNome = false;
                    nomeErro = '';
                  }
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Telefone',
                errorText: erroTelefone ? telErro : null, // Caso estiver errado, preenche com a mensagem de erro
              ),
              controller: telefoneController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                mascaraTel, // Mascara criada para o telefone
              ],
              onChanged: (value) { // Quando alterar
                setState(() {
                  // Verifica se o telefone possui 16 dígitos
                  if (telefoneController.text.length != 16) {
                    erroTelefone = true;
                    telErro = "Telefone Inválido!";
                  } else {
                    erroTelefone = false;
                    telErro = '';
                  }
                });
              },
            ),

            TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                errorText: erroEmail ? emailErro : null, // Caso o email estiver errado, preenche com a mensagem de erro
              ),
              controller: emailController,
              onChanged: (value) { // Quando alterar o valor
                setState(() {
                  // Verifica se o e-mail é válido
                  if (!(emailController.text.contains("@") && emailController.text.contains("."))) {
                    erroEmail = true;
                    emailErro = "E-mail Inválido!";
                  } else {
                    erroEmail = false;
                    emailErro = '';
                  }
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _validarCampos(); // Valida os campos
                if (!erroNome && !erroTelefone && !erroEmail) { // Verifica se todos os campos estão corretos
                  rc.addContato(Contato( // Atualiza o contato com as informações novas
                    nome: nomeController.text,
                    telefone: telefoneController.text,
                    email: emailController.text,
                  ));
                  Navigator.pop(context, true); // Retorna true para atualizar a lista na tela anterior
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