class Pauta{
  String id;
  String titulo;
  String descricao;
  String autor;
  String status;
  bool isExpanded = false;

  Pauta(this.id, this.titulo, this.descricao, this.autor, this.status);

  Pauta.fromMap(Map snapshot,String id) :
        id = id ?? '',
        titulo = snapshot['titulo'] ?? '',
        descricao = snapshot['descricao'] ?? '',
        autor = snapshot['autor'] ?? '',
        status = snapshot['status'] ?? '';

  toJson() {
    return {
      "titulo": titulo,
      "descricao": descricao,
      "autor": autor,
      "status": status,
    };
  }

  toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['titulo'] = this.titulo;
    map['descricao'] = this.descricao;
    map['autor'] = this.autor;
    map['status'] = this.status;
    return map;
  }


}