import 'package:profair/src/models/login_model.dart';
import 'package:dio/dio.dart';

class LoginRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";

  Future getLogin(Object data) async {
    clientDio.options.contentType = Headers.formUrlEncodedContentType;

    print(data);
    try {
      final response = await clientDio.post("https://profair.click/getuserweb", data: data);
      // final response = await clientDio.post("https://profair.click/getuserweb", data: data);
      print(response.data);
      // print(response.data[0]);
      final list = response.data[0];
      print("RESPONSE LOGIN WEB");
      return LoginModel.fromJson(list);
    } catch (e) {
      print("Error post login $e");
    }
  }
}
