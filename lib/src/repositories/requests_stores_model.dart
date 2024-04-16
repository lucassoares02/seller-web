class RequestsStoresModel {
  int? codeRequest;
  String? documentCompany;
  int? codeClient;
  int? codeBranch;
  String? nameClient;
  String? razaoClient;
  int? codeProvider;
  double? value;
  String? hour;

  RequestsStoresModel({
    this.codeRequest,
    this.documentCompany,
    this.codeClient,
    this.codeBranch,
    this.nameClient,
    this.razaoClient,
    this.codeProvider,
    this.value,
    this.hour,
  });

  RequestsStoresModel.fromJson(Map<String, dynamic> json) {
    codeRequest = json['codPedido'];
    documentCompany = json['cnpjAssociado'];
    codeClient = json['codAssociado'];
    codeProvider = json['codFornPedido'];
    codeBranch = json['codConsultRelaciona'];
    nameClient = json['nomeC  onsult'];
    razaoClient = json['razaoAssociado'];
    value = json['valor'].toDouble();
    hour = json['horas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codPedido'] = codeRequest;
    data['cnpjAssociado'] = documentCompany;
    data['codAssociado'] = codeClient;
    data['codConsultRelaciona'] = codeBranch;
    data['nomeConsult'] = nameClient;
    data['codFornPedido'] = codeProvider;
    data['razaoAssociado'] = razaoClient;
    data['valor'] = value;
    data['horas'] = hour;
    return data;
  }
}
