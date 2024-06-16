import 'package:profair/src/models/active_model.dart';
import 'package:dio/dio.dart';
import 'package:profair/src/models/historic_model.dart';

class ActionRepository {
  final Dio clientDio = Dio();

  Future<List<ActiveModel>?> getActives() async {
    clientDio.options.contentType = Headers.jsonContentType;

    Map<String, String> data = {"nomeCarteira": ""};
    try {
      // final response = await http.get(Uri.parse("https://g6b.online/api/Ativos/get-ativos"));
      // final list = response.body as List;

      final list = [
        {
          "simbolo": "VALE4",
          "longname": "Vale S.A.",
          "ativoId": 1,
          "valorAtivo": 27.09,
          "image":
              "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIABkAOAMBIgACEQEDEQH/xAAbAAABBAMAAAAAAAAAAAAAAAAABAUGBwECA//EAC4QAAEDAwICCQQDAAAAAAAAAAECAwQABRESMQZBExQhIlFhcXKBMjPBwgeRsf/EABkBAAIDAQAAAAAAAAAAAAAAAAAFAQIDBP/EACERAAICAQMFAQAAAAAAAAAAAAECAAMEQVHBERIhMdEF/9oADAMBAAIRAxEAPwCZfyBxfeeHrmxGixGERXkakSVgrKzzGOwDHzuK68M8d9aKW7ultGrsD7YwB7h+aknE9ijcRWh2BJ7pPeadxktLGyh+fEEiqaiMSYEmTbpyNEmMrStP+EeRGCPI1tWFbwYk/SuycZhah8baS7Zl0Yjt6kkOHlg9n91pZ571wbcccZShsHCFA/V49lVHwsm9369C1w5rrUBnvyVhIV0aPAEg4J2HyeVXC48zbhDjhspZcWGUkbIODjPrjHqRS1KcoXlrXHboBz1+xzj5Nd1AYKQTvxFlFNUi+R48TrTjbnRl9TScDJUEk6l+0BKj6ClqZaVT1xAk6ktJd1csEkfrXZLTq99pftNFIIdzE8SUoZKEN606itJJKVFOwORsd6KIRyqJ8bcMKuvRXC3oHX2RoKcgdM2eRPiCcj5HOnhX1H1rFSCQeomV1S3IUf0Zy4T4fY4dtKYrZC31npJD2PuLO/wNh5CnG4REzojkdSlI1YKVp3QoHKVDzBANI6KiXVQoCj1MrscV1MZt4rUxHYLSGwop3wCSQckkDHyfGhi1Ox3mXGpy9TbCGFFTYOtKSSM+fbWKKJabw7cYCZBS9rbWXF6S2AQVKKt9zuaK0oohP//Z",
        },
        {
          "simbolo": "BBAS3",
          "longname": "Banco do Brasil SA",
          "ativoId": 2,
          "valorAtivo": 27.43,
          "image":
              "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADgAAAAJCAMAAABQfh8kAAAAmVBMVEX94QD/5wD/6AD/5AD/4wD/5gD/5QD/6gCPjF7ZxDN0d2leZnFbZnLcxzC9r0ajm1XAskQdQH8AAIxlbW48UXrGtkCalFmwpU54emiWklpYY3Pu1R3n0CU2TnvOvDsKOYKDg2QALYUANYNNXHVEV3drcGzhyyunn1P02hYACosnRX59fmaNiF9hanAWPYAAHYgAMYQAKIb/9ABqQcRWAAABJUlEQVQokZWR25KCMAyGm7a0hQJFCoWKKIIcVgEP7/9wW3Vnr7wxk4skk+SffEHoaQwoZehro1xpVAkGGNOPDQRj71N5V4v9oRl4IMOIceo5x8QDghF3qwAg3m4Vx5xiIBwI/K2n07E1XZImfOM3zS4dxs0gdCiEzh6nXg5ZNox6+jHheeoueT3vy8V/TxIol6aLOK+7Y2QudlytuPKqZTeUTes8KlWs2SzGLtLnuN39DzpFu9jtS9H0dXAei6u9kvhA76iebkIpNWqWNqqLT6s/tbaU0QskRbYW/j0GCKTMg0dvfFEIWRS65JfAVGFYJe7GIleyyvu5z40IXpIkSbhakMPmqBJA4FGPecAYuNgljs+TKnO4KAHHzHPB+0by/OO3P/wFxRAW2Ab3lwEAAAAASUVORK5CYII=",
        },
      ];
      return list.map((json) => ActiveModel.fromJson(json)).toList();
    } catch (e) {
      print("Error Home Repository: $e");
    }
  }

  Future<List<HistoricModel>?> getHistoric(String? active) async {
    clientDio.options.contentType = Headers.jsonContentType;
    Map<String, String> data = {"nomeCarteira": ""};
    try {
      final response = await clientDio.get("https://g6b.online/api/Ativos/buscar-historico-ativos?Ativo=${active}");
      final list = response.data as List;
      return list.map((json) => HistoricModel.fromJson(json)).toList();
    } catch (e) {
      print("Error Home Repository: $e");
    }
  }
}
