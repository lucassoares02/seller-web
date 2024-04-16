import 'package:profair/src/repositories/products_provider_model.dart';
import 'package:dio/dio.dart';

class ProductsProviderRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";

  getProductsProvider(int? codeProvider, int? codeClient) async {
    Response response;
    try {
      if (codeClient != 0) {
        response = await clientDio.get("${url}merchandisepercustomer/$codeClient/$codeProvider");
      } else {
        response = await clientDio.get("${url}merchandiseprovider/$codeProvider");
      }
      List list = response.data as List;
      return list.map((json) => ProductsProviderModel.fromJson(json, 0)).toList();
    } catch (e) {
      print("Error return Stores Model Mapper: $e");
    }
  }
}
