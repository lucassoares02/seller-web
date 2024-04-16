class DetailsProvider {
  int? codeProvider;
  String? nameProvider;
  String? razaoProvider;
  String? documentProvider;
  String? phoneProvider;
  int? codeCategory;
  int? codeBuyer;
  int? codConsult;
  String? nameConsult;
  String? documentConsult;
  String? phoneConsult;
  int? codProviderConsult;
  String? emailConsult;

  DetailsProvider(
      {this.codeProvider,
      this.nameProvider,
      this.razaoProvider,
      this.documentProvider,
      this.phoneProvider,
      this.codeCategory,
      this.codeBuyer,
      this.codConsult,
      this.nameConsult,
      this.documentConsult,
      this.phoneConsult,
      this.codProviderConsult,
      this.emailConsult});

  DetailsProvider.fromJson(Map<String, dynamic> json) {
    codeProvider = json['codForn'];
    nameProvider = json['nomeForn'];
    razaoProvider = json['razaoForn'];
    documentProvider = json['cnpjForn'];
    phoneProvider = json['telForn'];
    codeCategory = json['codCategoria'];
    codeBuyer = json['codComprFornecedor'];
    codConsult = json['codConsult'];
    nameConsult = json['nomeConsult'];
    documentConsult = json['cpfConsult'];
    phoneConsult = json['telConsult'];
    codProviderConsult = json['codFornConsult'];
    emailConsult = json['emailConsult'];

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};

      data['codForn'] = codeProvider;
      data['nomeForn'] = nameProvider;
      data['razaoForn'] = razaoProvider;
      data['cnpjForn'] = documentProvider;
      data['telForn'] = phoneProvider;
      data['codCategoria'] = codeCategory;
      data['codComprFornecedor'] = codeBuyer;
      data['codConsult'] = codConsult;
      data['nomeConsult'] = nameConsult;
      data['cpfConsult'] = documentConsult;
      data['telConsult'] = phoneConsult;
      data['codFornConsult'] = codProviderConsult;
      data['emailConsult'] = emailConsult;
      return data;
    }
  }
}
