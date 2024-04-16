class NegotiationModel {
  int? negotiation;
  String? title;
  int? confirm;
  bool? checked;
  double? value;

  NegotiationModel({this.negotiation, this.title, this.confirm, this.checked, this.value});

  NegotiationModel.fromJson(Map<String, dynamic> json) {
    negotiation = json["codNegociacao"];
    title = json["descNegociacao"];
    confirm = json["confirma"];
    checked = false;
    value = json["total"] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["codNegociacao"] = negotiation;
    data["descNegociacao"] = title;
    data["confirma"] = confirm;
    data["checked"] = false;
    data["total"] = value;
    return data;
  }
}
