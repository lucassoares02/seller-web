class GraphClients {
  String? client;
  String? percentage;
  double? value;

  GraphClients({this.client, this.percentage, this.value});

  GraphClients.fromJson(Map<String, dynamic> json) {
    // codeBranch = json['codAssocRelaciona'];
    client = json['razao'];
    percentage = json['percentage'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['codAssocRelaciona'] = codeBranch;
    data['razao'] = client;
    data['percentage'] = percentage;
    data['value'] = value;
    return data;
  }
}
