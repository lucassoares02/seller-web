import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:profair/src/models/nogotiation_model.dart';
import 'package:profair/src/repositories/details_provider.dart';
import 'package:profair/src/repositories/products_provider_model.dart';

class RequestClientRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";

  getNegotiation(int codeBranch, int codeProvider) async {
    try {
      final response = await clientDio.get("${url}negotiationclientwithprice/$codeBranch/$codeProvider");

      List list = response.data as List;
      return list.map((json) => NegotiationModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint("Error return Negotiation Model Mapper: $e");
    }
  }

  getMerchandises(int codeBranch, int codeProvider, int codeTranding) async {
    Response? response;
    try {
      if (codeTranding != 0) {
        response = await clientDio.get("${url}merchandiseproviderifclient/$codeBranch/$codeProvider/$codeTranding");
        List list = response.data as List;
        return list.map((json) => ProductsProviderModel.fromJson(json, 1)).toList();
      } else {
        response = await clientDio.get("${url}merchandiseperclient/$codeBranch/$codeProvider");
        List list = response.data as List;
        return list.map((json) => ProductsProviderModel.fromJson(json, 0)).toList();
      }
    } catch (e) {
      debugPrint("Error return Products Model Mapper: $e");
    }
  }

  getDetailsProvider(int codeProvider) async {
    Response? response;
    try {
      response = await clientDio.get("${url}providerdetails/$codeProvider");
      final list = response.data;
      return DetailsProvider.fromJson(list);
    } catch (e) {
      debugPrint("Error return Products Model Mapper: $e");
    }
  }
}
