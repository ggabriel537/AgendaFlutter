import 'package:agenda_flutter/entidades/Contato.dart';

abstract class InterfaceDao {
  Future<void> adicionar(Contato c);
  Future<int> remover(Contato c);
  Future<List<Contato>> get contatos;
  Future<Contato> atualizar(Contato novo);
}