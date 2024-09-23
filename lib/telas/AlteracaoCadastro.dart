import 'package:flutter/material.dart';
import '../entidades/Contato.dart';
import '../outros/RepositorioContato.dart';

class AlteracaoCadastro extends StatefulWidget {
  final Repositoriocontato rc;
  final Contato contato;
  final int index;

  AlteracaoCadastro({required this.rc, required this.contato, required this.index});

  @override
  State<AlteracaoCadastro> createState() => _AlteracaoCadastroState(rc: rc, contato: contato, indicec: index);
}

class _AlteracaoCadastroState extends State<AlteracaoCadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final Repositoriocontato rc;
  final int indicec; // Índice do contato

  _AlteracaoCadastroState({required this.rc, required Contato contato, required this.indicec}) { //Controller de cada campo
    nomeController.text = contato.nome;
    telefoneController.text = contato.telefone;
    emailController.text = contato.email;
  }

  void _confirmarRemocao(BuildContext context) {
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
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text('Remover'),
              onPressed: () {
                setState(() {
                  rc.removerContato(widget.contato); // Remove o contato
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Contato ' + nomeController.text + ' removido com sucesso!'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).pop(); // Fecha o diálogo
                Navigator.pop(context, true); // Retorna à tela anterior
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alteração de Contatos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            ElevatedButton(
              onPressed: () {
                rc.atualizarContato(Contato( // Atualiza o contato com as informações novas
                  nome: nomeController.text,
                  telefone: telefoneController.text,
                  email: emailController.text,
                ), indicec);
                Navigator.pop(context, true); // Retorna true para atualizar a lista na tela anterior
              },
              child: Text('Salvar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _confirmarRemocao(context), // Chama o método de confirmação
              child: Text('Remover Contato'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white70), // Altera a cor do botão para cinza
            ),
          ],
        ),
      ),
    );
  }
}
