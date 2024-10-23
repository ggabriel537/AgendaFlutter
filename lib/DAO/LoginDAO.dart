import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../entidades/Login.dart';

class LoginDAO {
  Future<Database> initializeDB() async {
    String path = join(await getDatabasesPath(), 'LoginSystem.db');
    return await openDatabase(path, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE IF NOT EXISTS usuarios(user TEXT PRIMARY KEY, senha TEXT)",
      );
    }, version: 1);
  }

  Future<void> adicionarUsuario(Login l) async {
    final Database db = await initializeDB();
    await db.insert('usuarios', l.toMap());
  }

  Future<bool> verificarUsuario(Login l) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'user = ? AND senha = ?',
      whereArgs: [l.user, l.senha],
    );
    return maps.isNotEmpty;
  }

  Future<List<Login>> get logins async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return List.generate(maps.length, (i) {
      return Login.fromMap(maps[i]);
    });
  }

  Future<int> removerUsuario(Login l) async {
    final Database db = await initializeDB();
    return await db.delete("usuarios", where: 'user = ?', whereArgs: [l.user]);
  }

  Future<void> atualizar(Login novo) async {
    final Database db = await initializeDB();
    await db.rawUpdate(
        "UPDATE usuarios SET senha = ? WHERE user = ?", [novo.senha, novo.user]
    );
    await db.close();
  }

  Future<bool> checarPrimeiroLogin() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return maps.isNotEmpty;
  }
}
