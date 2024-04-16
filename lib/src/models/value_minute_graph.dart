class ValueMinutesGraph {
  String? hour;
  double? value;

  ValueMinutesGraph({this.hour, this.value});

  ValueMinutesGraph.fromJson(Map<String, dynamic> json) {
    // codeBranch = json['codAssocRelaciona'];
    hour = json['hour'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['codAssocRelaciona'] = codeBranch;
    data['hour'] = hour;
    data['value'] = value;
    return data;
  }
}
