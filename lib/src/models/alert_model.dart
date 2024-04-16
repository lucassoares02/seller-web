class AlertModel {
  String? title;
  int? priority;
  String? time;
  String? description;

  AlertModel({
    this.title,
    this.priority,
    this.time,
    this.description,
  });

  AlertModel.fromJson(Map<String, dynamic> json) {
    // codeBranch = json['codAssocRelaciona'];
    title = json['title'];
    priority = json['priority'];
    time = json['time'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['codAssocRelaciona'] = codeBranch;
    data['title'] = title;
    data['priority'] = priority;
    data['time'] = time;
    data['description'] = description;
    return data;
  }
}
