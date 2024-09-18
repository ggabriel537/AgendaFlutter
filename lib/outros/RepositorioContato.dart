import 'package:agenda_flutter/entidades/Contato.dart';

class Repositoriocontato { //Classe com uma lista de contatos para mostrar em uma tela
  final List<Contato> contatos = [];

  void addContato(Contato c) {
    contatos.add(c);
  }

  List<Contato> getContatos() {
    return contatos;
  }
}