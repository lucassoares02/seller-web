class HistoricModel {
  int? id;
  String? date;
  double? open;
  double? high;
  double? low;
  double? close;
  int? volume;
  double? adjustedClose;
  int? ativosId;

  HistoricModel({
    this.id,
    this.date,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.adjustedClose,
    this.ativosId,
  });

  HistoricModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    open = json['open'];
    high = json['high'];
    low = json['low'];
    close = json['close'];
    volume = json['volume'];
    adjustedClose = json['adjustedClose'];
    ativosId = json['ativosId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['open'] = open;
    data['high'] = high;
    data['low'] = low;
    data['close'] = close;
    data['volume'] = volume;
    data['adjustedClose'] = adjustedClose;
    data['ativosId'] = ativosId;
    return data;
  }
}
