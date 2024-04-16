import 'package:profair/src/repositories/requests_stores_model.dart';
import 'package:dio/dio.dart';

class RequestsStoresRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";

  getRequestsStores(int? codeProvider, int? userCode) async {
    Response? response;
    print("=============================");
    print(codeProvider);
    print(userCode);
    print("=============================");
    try {
      if (codeProvider == 0 && userCode == 0) {
        response = await clientDio.get("${url}allrequestclients");
      } else if (codeProvider == 0 && userCode != 0) {
        response = await clientDio.get("${url}stores/$userCode");
      } else {
        response = await clientDio.get("${url}requestsprovider/$codeProvider");
      }
      List list = response.data as List;
      return list.map((json) => RequestsStoresModel.fromJson(json)).toList();
    } catch (e) {
      print("Error return Stores Model Mapper: $e");
    }
  }
}
