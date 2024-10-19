import 'package:agenda_flutter/DAO/Dao.dart';
import 'package:agenda_flutter/outros/RepositorioContato.dart';
import 'package:flutter/material.dart';
import '../entidades/Contato.dart';
import 'AlteracaoCadastro.dart';

class Selecaoalt extends StatefulWidget {
  final Repositoriocontato rc;

  Selecaoalt({required this.rc});

  @override
  State<Selecaoalt> createState() => ListagemState(rc: rc);
}

class ListagemState extends State<Selecaoalt> {
  Repositoriocontato rc = Repositoriocontato();
  List<Contato> contatos = [];

  ListagemState({required this.rc});

  @override
  void initState() {
    super.initState();
    _loadContatos();
  }

  Future<void> _loadContatos() async {
    Dao cd = Dao(rc: rc);
    contatos = await cd.contatos;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de contatos'),
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          Contato c = contatos[index];
          return ListTile(
            title: Text(c.nome),
            subtitle: Text("- Telefone: " + c.telefone + "\n- Email: " + c.email),
            onTap: () async {
              final altCad = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlteracaoCadastro(
                    contato: c,
                    rc: rc,
                  ),
                ),
              );
              if (altCad == true) {
                _loadContatos();
              }
            },
          );
        },
      ),
    );
  }
}
