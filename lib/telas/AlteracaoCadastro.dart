import 'package:agenda_flutter/Repositorios/RepositorioContato.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../DAO/DaoC.dart';
import '../entidades/Contato.dart';

class AlteracaoCadastro extends StatefulWidget {
  final Contato contato;
  final Repositoriocontato rc;

  AlteracaoCadastro({required this.contato, required this.rc});

  @override
  State<AlteracaoCadastro> createState() => _AlteracaoCadastroState(contato: contato, rc: rc);
}

class _AlteracaoCadastroState extends State<AlteracaoCadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

   Repositoriocontato rc ;
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

  _AlteracaoCadastroState({required Contato contato, required this.rc}) {
    nomeController.text = contato.nome;
    telefoneController.text = contato.telefone;
    emailController.text = contato.email;
  }

  void _confirmarRemocao(BuildContext context) {
    DaoC cd = DaoC(rc: rc);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Remoção'),
          content: Text("Você tem certeza que deseja remover o contato " + nomeController.text + "?"),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Remover'),
              onPressed: () async {
                //await rc.removerContato(widget.contato.id!);
                cd.remover(Contato(
                  id: widget.contato.id,
                  nome: "",
                  telefone: "",
                  email: ""
                ));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Contato ' + nomeController.text + ' removido com sucesso!'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).pop();
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

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
    DaoC cd = DaoC(rc: rc);
    return Scaffold(
      appBar: AppBar(
        title: Text('Alteração de Contatos'),
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
                  await cd.atualizar(Contato(
                    id: widget.contato.id,
                    nome: nomeController.text,
                    telefone: telefoneController.text,
                    email: emailController.text
                  ));
                  /*await rc.atualizarContato(Contato(
                    id: widget.contato.id,
                    nome: nomeController.text,
                    telefone: telefoneController.text,
                    email: emailController.text,
                  ));*/
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _confirmarRemocao(context),
              child: Text('Remover Contato'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
