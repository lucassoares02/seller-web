import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UploadRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";
  // final String url = "https://profair.click/";

  // upload(List<CompanyUpload> clients) async {
  //   try {
  //     for (int j = 0; j < clients.length; j++) {
  //       Map<String?, String?> data = {
  //         "codForn": clients[j].code.toString(),
  //         "nomeForn": clients[j].name.toString(),
  //         "razaoForn": clients[j].social.toString(),
  //         "cnpjForn": clients[j].document.toString(),
  //         "telForn": clients[j].phone.toString(),
  //         "type": clients[j].type.toString(),
  //         "categoria": clients[j].category.toString(),
  //       };
  //       await http.post(Uri.parse("${url}insertprovider"), body: data);
  //     }
  //   } catch (e) {
  //     debugPrint("Error return Negotiation Model Mapper: $e");
  //   }
  // }

  uploadProvider(Object provider) async {
    try {
      final response = await http.post(Uri.parse("${url}insertprovider"), body: provider);
      if (response.statusCode == 400) {
        throw response.statusCode;
      }
      return 200;
      // }
    } catch (e) {
      debugPrint("Error return Insert Provider: $e");
      return 400;
    }
  }

  uploadPeople(Object people) async {
    try {
      await http.post(Uri.parse("${url}insertperson"), body: people);
      return 200;
    } catch (e) {
      print("Error Upload People: ${e}");
      return 400;
    }
  }

  uploadMerchandise(Object? data) async {
    try {
      final response = await http.post(Uri.parse("${url}insertmerchandise"), body: data);

      if (response.statusCode == 400) {
        throw response.statusCode;
      }
      return 200;
      // }
    } catch (e) {
      debugPrint("Error return Merchandise Model Mapper: $e");
      print("--------------------------------------------");
      print(data);
      print("--------------------------------------------");
      return 400;
    }
  }

  uploadNegotiation(Object? data) async {
    try {
      final response = await http.post(Uri.parse("${url}insertnegotiation"), body: data);
      if (response.statusCode == 400) {
        throw response.statusCode;
      }
      return 200;
      // }
    } catch (e) {
      debugPrint("Error return Negotiation Model Mapper");
      return 400;
    }
  }

  uploadRelacionamentoMercadorias(Object? data) async {
    print(data);
    try {
      final response = await http.post(Uri.parse("${url}insertnegotiationrelacionamercadoria"), body: data);
      if (response.statusCode == 400) {
        throw response.statusCode;
      }
      return 200;
      // }
    } catch (e) {
      debugPrint("Error return Negotiation Model Mapper");
      return 400;
    }
  }
}
