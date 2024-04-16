import 'package:profair/src/models/clients_model.dart';
import 'package:dio/dio.dart';

class ClientsRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";

  getClients(String? codeProvider, int accessTargenting, int merchandise, int? trading) async {
    Response? response;
    try {
      if (merchandise != 0 && trading != 0) {
        print("step 1");
        response = await clientDio.get("${url}clientmerchandisetrading/$merchandise/$trading");
      } else if (accessTargenting == 3) {
        print("step 2");

        response = await clientDio.get("${url}stores");
      } else {
        print("step 3");
        response = await clientDio.get("${url}storesbyprovider/$codeProvider");
      }
      List list = response.data as List;

      return list.map((json) => ClientsModel.fromJson(json)).toList();
    } catch (e) {
      print("Error return Stores Model Mapper: $e");
    }
  }
}
