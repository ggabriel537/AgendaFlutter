import 'package:flutter/material.dart';
import '../entidades/Contato.dart';
import '../outros/RepositorioContato.dart';
import 'AlteracaoCadastro.dart';

class Selecaoalt extends StatefulWidget {
  final Repositoriocontato rc;

  Selecaoalt({required this.rc});

  @override
  State<Selecaoalt> createState() => ListagemState(rc: rc);
}

class ListagemState extends State<Selecaoalt> {
  final Repositoriocontato rc;

  ListagemState({required this.rc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de contatos'),
      ),
      body: ListView.builder( //Listagem dos contatos existentes
        itemCount: rc.getContatos().length,
        itemBuilder: (context, index) {
          Contato c = rc.getContatos()[index];
          return ListTile(
            title: Text(c.nome),
            subtitle: Text("- Telefone: " + c.telefone + "\n- Email: " + c.email),
            onTap: () async { //Quando usuário clicar no botão ele abre a tela de alteração de cadastro e envia os dados do contato selecionado
              //Função async para quando o usuário sair da tela de cadastro ele automaticamente atualizar a lista dos contatos
              final altCad = await Navigator.push( //abre a janela de alteração de cadastro o programa espera um retorno caso o usuário tenha alterado alguma coisa na tela a seguir
                context,
                MaterialPageRoute(
                  builder: (context) => AlteracaoCadastro(
                    rc: rc,
                    contato: c,
                    index: index,
                  ),
                ),
              );
              if (altCad == true) { //caso houver alteração ele recarrega as informações
                setState(() {
                });
              }
            },
          );
        },
      ),
    );
  }
}
