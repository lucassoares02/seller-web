class DetailsWallet {
  int? id;
  String? date;
  double? performance;
  double? investiment;
  int? count;
  double? appreciation;

  DetailsWallet({
    this.id,
    this.date,
    this.performance,
    this.investiment,
    this.count,
    this.appreciation,
  });

  DetailsWallet.fromJson(Map<String, dynamic> json) {
    id = json['carteiraId'];
    date = json['dataHora'];
    performance = json['totalValorAtual'];
    investiment = json['totalInvestimento'];
    count = json['countAtivos'];
    appreciation = json['valorizacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['performance'] = performance;
    data['investiment'] = investiment;
    data['countAtivos'] = count;
    data['valorizacao'] = appreciation;
    return data;
  }
}
