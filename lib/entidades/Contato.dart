class Contato {
  int? id;
  String nome;
  String telefone;
  String email;

  Contato({this.id, required this.nome, required this.telefone, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> mapa) {
    return Contato(
      id: mapa['id'],
      nome: mapa['nome'],
      telefone: mapa['telefone'],
      email: mapa['email'],
    );
  }
}
