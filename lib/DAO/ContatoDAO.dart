import 'package:agenda_flutter/DAO/InterfaceDao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../entidades/Contato.dart';

class ContatoDAO implements InterfaceDao {
  Future<Database> initializeDB() async {
    String path = join(await getDatabasesPath(), 'AgendaFlutter.db');
    return await openDatabase(path, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, email TEXT, telefone TEXT)",
      );
    }, version: 1);
  }


  @override
  Future<void> adicionar(Contato c) async {
    final Database db = await initializeDB();
    await db.insert('contatos', c.toMap());
    db.close();
  }

  @override
  Future<Contato> atualizar(Contato novo) async {
    final Database db = await initializeDB();
    db.rawUpdate(
      "UPDATE contatos SET nome = ?, telefone = ?, email = ? WHERE id = ?", [novo.nome, novo.telefone, novo.email, novo.id]
    );
    return novo as Future<Contato>;
  }

  @override
  Future<List<Contato>> get contatos async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('pessoas');
    return List.generate(maps.length, (i) {
      return Contato.fromMap(maps[i]);
    });
  }

  @override
  Future<int> remover(Contato c) async {
    final Database db = await initializeDB();
    return await db.delete("pessoas", where: 'id = ?', whereArgs: [c.id]);
  }

}
