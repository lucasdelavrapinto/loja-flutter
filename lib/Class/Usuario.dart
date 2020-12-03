import 'dart:convert';

class Usuario {

  final String name;
  final String email;
  final String telefone;
  final String pontos;
  final String cpf;

  const Usuario(this.name, this.email, this.telefone, this.pontos, this.cpf);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'telefone': telefone,
      'pontos': pontos,
      'cpf': cpf,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Usuario(
      map['name'].toString(),
      map['email'].toString(),
      map['telefone'].toString(),
      map['pontos'].toString(),
      map['cpf'].toString()
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source));
}
