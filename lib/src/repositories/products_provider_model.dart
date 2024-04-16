class ProductsProviderModel {
  int? codeProvider;
  String? nameProvider;
  int? codeProduct;
  String? nameProduct;
  String? packing;
  int? coefficient;
  double? productPrice;
  double? unitPrice;
  double? totalValue;
  String? totalVolume;

  ProductsProviderModel({
    this.codeProvider,
    this.nameProvider,
    this.codeProduct,
    this.nameProduct,
    this.packing,
    this.coefficient,
    this.productPrice,
    this.unitPrice,
    this.totalValue,
    this.totalVolume,
  });

  ProductsProviderModel.fromJson(Map<String, dynamic> json, int valid) {
    if (valid == 1) {
      codeProduct = json['codMercadoria'];
      nameProduct = json['nomeMercadoria'];
      packing = json['embMercadoria'];
      coefficient = json['fatorMerc'];
      productPrice = json['precoMercadoria'] != null ? double.parse(json["precoMercadoria"].toString()) : json["precoMercadoria"];
      totalValue = (json['precoMercadoria'] * json["quantMercadoria"]);
      totalVolume = json['quantMercadoria'].toString();
    } else {
      codeProvider = json['codForn'];
      nameProvider = json['nomeForn'];
      codeProduct = json['codMercadoria'];
      nameProduct = json['nomeMercadoria'];
      packing = json['embMercadoria'];
      coefficient = json['fatorMerc'];
      productPrice = json['precoMercadoria'] != null ? double.parse(json["precoMercadoria"].toString()) : json["precoMercadoria"];
      unitPrice = json['precoUnit'] != null ? double.parse(json['precoUnit'].toString()) : json['precoUnit'];
      totalValue = json['precoMercadoria'] * double.parse(json["volumeTotal"].toString());
      totalVolume = json['volumeTotal'].toString();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['codMercadoria'] = codeProduct;
    data['nomeMercadoria'] = nameProduct;
    data['embMercadoria'] = packing;
    data['fatorMerc'] = coefficient;
    data['precoMercadoria'] = productPrice;
    data['volumeTotal'] = totalVolume;
    data['valorTotal'] = totalValue;
    data['precoUnit'] = unitPrice;
    data['codForn'] = codeProvider;
    data['nomeForn'] = nameProvider;
    return data;
  }
}

// {
// 		"codMercadoria": 4427,
// 		"nomeMercadoria": "Refri Coroa Mini Pet 12X250Ml Laranja",
// 		"embMercadoria": "FD",
// 		"fatorMerc": 12,
// 		"precoMercadoria": 9,
// 		"volumeTotal": "1000"
// 		"valorTotal": 9000,
// 		"precoUnit": 0.75,
// 		"codForn": 333,
// 		"nomeForn": "Refrigerantes Coroa Ltda",

// 	},