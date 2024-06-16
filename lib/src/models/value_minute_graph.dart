class DataLineGraph {
  String? data;
  double? close;
  int? id;

  DataLineGraph({this.id, this.data, this.close});

  DataLineGraph.fromJson(Map<String, dynamic> json) {
    id = json['ativoId'];
    data = json['dataHora'];
    close = json['rendimentoDiario'] ?? json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AtivoId'] = id;
    data['data'] = data;
    data['close'] = close;
    return data;
  }
}
