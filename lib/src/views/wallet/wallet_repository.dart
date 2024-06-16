import 'package:profair/src/models/active_model.dart';
import 'package:dio/dio.dart';
import 'package:profair/src/models/historic_model.dart';

class WalletRepository {
  final Dio clientDio = Dio();

  Future<List<ActiveModel>?> getActives(bool active) async {
    clientDio.options.contentType = Headers.jsonContentType;
    Map<String, String> data = {"nomeCarteira": ""};
    print("https://g6b.online/api/Ativos/get-ativos?paridadeRiscos=$active");
    try {
      final response = await clientDio.get("https://g6b.online/api/Ativos/get-ativos?paridadeRiscos=$active");
      final list = response.data["data"] as List;
      print(list);
      return list.map((json) => ActiveModel.fromJson(json)).toList();
    } catch (e) {
      print("Error Home Repository: $e");
    }
  }
}
