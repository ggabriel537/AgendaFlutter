
class Login{
  String user;
  String senha;

  Login({required this.user, required this.senha});

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'senha': senha,
    };
  }

  factory Login.fromMap(Map<String, dynamic> mapa) {
    return Login(
      user: mapa['user'],
      senha: mapa['senha'],
    );
  }
}