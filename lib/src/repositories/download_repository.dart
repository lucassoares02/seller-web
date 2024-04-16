import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/models/providers_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";

  Future<List<ProvidersModel>> getProvidersByCompany(int client) async {
    clientDio.options.contentType = Headers.formUrlEncodedContentType;
    final response = await clientDio.get("${url}requesttopproviderclient/$client");

    final item = response.data as List;
    return item.map((json) => ProvidersModel.fromJson(json)).toList();
  }

  download() async {
    try {
      if (await canLaunch("${url}exportnegotiations")) {
        await launch("${url}exportnegotiations");
      } else {
        print('Não foi possível abrir o navegador');
      }
      return 200;
      // }
    } catch (e) {
      debugPrint("Error return Negotiation Model Mapper");
      return 400;
    }
  }

  downloadClient(int codeClient) async {
    try {
      if (await canLaunch("${url}exportnegotiationsclient/$codeClient")) {
        await launch("${url}exportnegotiationsclient/$codeClient");
      } else {
        print('Não foi possível abrir o navegador');
      }
      return 200;
      // }
    } catch (e) {
      debugPrint("Error return Negotiation Model Mapper");
      return 400;
    }
  }

  downloadClientProvider(int codeClient, int codeProvider) async {
    try {
      if (await canLaunch("${url}exportnegotiationsclientprovider/$codeClient/$codeProvider")) {
        await launch("${url}exportnegotiationsclientprovider/$codeClient/$codeProvider");
      } else {
        print('Não foi possível abrir o navegador');
      }
      return 200;
      // }
    } catch (e) {
      debugPrint("Error return Negotiation Model Mapper");
      return 400;
    }
  }
}
