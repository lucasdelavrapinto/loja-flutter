class Produto {
  final num id;
  final String descricao;
  final String urlImg;
  final num pontos;
  final String data;

  Produto(this.id, this.descricao, this.urlImg, this.pontos, this.data)
      : assert(id != null),
        assert(descricao != null),
        assert(urlImg != null),
        assert(data != null);

  Produto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        descricao = json['descricao'],
        urlImg = json['img'],
        pontos = json['pontos'],
        data = json['created_at'];
}
