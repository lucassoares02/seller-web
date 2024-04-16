import 'package:profair/src/models/graph_clients.dart';
import 'package:profair/src/models/login_model.dart';
import 'package:profair/src/models/value_minute_graph.dart';
import 'package:profair/src/repositories/buyers_model.dart';
import 'package:profair/src/repositories/categories_icon.dart';
import 'package:profair/src/repositories/categories_model.dart';
import 'package:profair/src/repositories/information_model.dart';
import 'package:profair/src/repositories/notice_model.dart';
import 'package:profair/src/repositories/recipe_model.dart';
import 'package:profair/src/repositories/requests_stores_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";

  Future getData(Object data) async {
    clientDio.options.contentType = Headers.formUrlEncodedContentType;

    try {
      // final response = await clientDio.post("https://profair.click/getuserweb", data: data);
      // final response = await clientDio.post("https://profair.click/getuserweb", data: data);
      final response = await clientDio.post("https://profair.click/getusermore", data: data);
      print("========================================");
      print("response.data");
      print("========================================");
      print(response.data);
      print("========================================");

      final item = response.data as List;
      return item.map((json) => LoginModel.fromJson(json)).toList();
    } catch (e) {
      print("Error getData client: $e");
      return false;
    }
  }

  Future<LoginModel> getClient(String id) async {
    clientDio.options.contentType = Headers.formUrlEncodedContentType;

    final response = await clientDio.get("${url}client/$id");

    final item = response.data[0];
    return LoginModel.fromJson(item);
  }

  Future<double> getValueFair() async {
    clientDio.options.contentType = Headers.formUrlEncodedContentType;

    final response = await clientDio.get("${url}valuefair");

    return response.data[0]["value"] ?? 0;
  }

  getCategoriesHome() async {
    final response = await clientDio.post('https://profair-backend.onrender.com/categories');
    List list = response.data as List;
    return list.map((json) => CategoriesModel.fromJson(json)).toList();
  }

  getNotices() async {
    final response = await clientDio.get('${url}notices');
    List list = response.data as List;
    return list.map((json) => NoticeModel.fromJson(json)).toList();
  }

  getSharedHome() async {
    final response = await clientDio.get('https://profair-backend.onrender.com/cookbook');
    List list = response.data as List;
    return list.map((json) => RecipeModel.fromJson(json)).toList();
  }

  getLastTradings(int? codeProvider) async {
    final response = await clientDio.get('${url}requestsprovider/$codeProvider');
    List list = response.data as List;
    return list.map((json) => RequestsStoresModel.fromJson(json)).toList();
  }

  getBuyers() async {
    final response = await clientDio.get('${url}buyers');
    print("RESPONES BUYERS");
    print(response);
    print("RESPONES BUYERS");
    List list = response.data as List;
    return list.map((json) => BuyersModel.fromJson(json)).toList();
  }

  getCategoriesss(int code) async {
    List list = [
      if (code == 1)
        {
          "id": 14,
          "title": 'Novo',
          "icon": Icons.add_outlined,
          "route": "selectstore",
        },
      if (code == 1)
        {
          "id": 34,
          "title": 'Produtos',
          "icon": Icons.shopping_basket_rounded,
          "route": "productsprovider",
        },
      if (code == 3)
        {
          "id": 54,
          "title": code == 1 ? 'Clientes' : 'Associados',
          "icon": Icons.groups_2_sharp,
          "route": "clients",
        },
      if (code == 3 || code == 2)
        {
          "id": 64,
          "title": 'Fornecedores',
          "icon": Icons.business_rounded,
          "route": "selectprovider",
        },
      if (code == 1)
        {
          "id": 84,
          "title": 'Negociações',
          "icon": Icons.swap_horiz_rounded,
          "route": "tradings",
        },
      {
        "id": 84,
        "title": 'Relatórios',
        "icon": Icons.show_chart_rounded,
        "route": "reports",
      },
      {
        "id": 74,
        "title": 'Dúvidas',
        "icon": Icons.messenger_outline_outlined,
        "route": "faq",
      },
      {
        "id": 24,
        "title": 'Contatos',
        "icon": Icons.phone,
        "route": "contacts",
      },
    ];
    return list.map((json) => CategoriesIcon.fromJson(json)).toList();
  }

  getInformation() async {
    try {
      final response = await clientDio.get('${url}information');
      List list = response.data as List;
      return list.asMap().entries.map((json) => InformationModel.fromJson(json.value, json.key)).toList();
    } catch (e) {
      print("Error Get Information: $e");
    }
  }

  getChartClients() async {
    try {
      final response = await clientDio.get('${url}storesgraph');
      List list = response.data["item"] as List;
      return list.map((json) => GraphClients.fromJson(json)).toList();
    } catch (e) {
      print("Error Get Information: $e");
    }
  }

  getChartPorMinute() async {
    try {
      final response = await clientDio.get('${url}valueminutegraph');
      List list = response.data as List;
      return list.map((json) => ValueMinutesGraph.fromJson(json)).toList();
    } catch (e) {
      print("Error Get Information: $e");
    }
  }
}
