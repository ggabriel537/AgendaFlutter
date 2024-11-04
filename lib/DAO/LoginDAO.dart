import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../entidades/Login.dart';

class LoginDAO {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> salvarToken(String token) async {
    await _secureStorage.write(key: 'login_token', value: token);
  }

  Future<bool> verificarToken() async {
    String? token = await _secureStorage.read(key: 'login_token');
    return token != null;
  }

  Future<void> removerToken() async {
    await _secureStorage.delete(key: 'login_token');
  }


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
