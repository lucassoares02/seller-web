class ActiveModel {
  String? symbol;
  String? longName;
  String? image;
  int? ativoId;
  double? valorAtivo;
  double? investimento;
  double? renda;
  double? valorizacao;
  String? dataHora;

  ActiveModel({
    this.symbol,
    this.longName,
    this.image,
    this.investimento,
    this.renda,
    this.valorizacao,
    this.dataHora,
  });

  ActiveModel.fromJson(Map<String, dynamic> json) {
    symbol = json['simbolo'];
    longName = json['longname'];
    ativoId = json['ativoId'];
    image = json['urlImagem'];
    valorAtivo = json['valorAtivo'];
    investimento = json['investimento'];
    renda = json['renda'];
    valorizacao = (json['valorizacao'] * -1);
    dataHora = json['dataHora'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['longName'] = longName;
    data['urlImagem'] = image;
    data['ativoId'] = ativoId;
    data['valorAtivo'] = valorAtivo;
    data['investimento'] = investimento;
    data['renda'] = renda;
    data['valorizacao'] = valorizacao;
    data['dataHora'] = dataHora;
    return data;
  }
}
