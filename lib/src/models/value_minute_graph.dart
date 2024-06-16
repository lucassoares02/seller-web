class DataLineGraph {
  String? data;
  double? close;
  int? id;
  String? symbol;

  DataLineGraph({this.id, this.data, this.close, this.symbol});

  DataLineGraph.fromJson(Map<String, dynamic> json) {
    id = json['ativoId'];
    data = json['dataHora'];
    symbol = json['symbol'];
    close = json['rendimentoDiario'] ?? json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AtivoId'] = id;
    data['data'] = data;
    data['close'] = close;
    data['symbol'] = symbol;
    return data;
  }
}
