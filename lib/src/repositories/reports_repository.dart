import 'package:profair/src/models/product_model.dart';
import 'package:profair/src/models/total_value_clients.dart';
import 'package:profair/src/repositories/percentage_clients_model.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReportsRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";

  getPercentageClients(int? codeProvider, int? accessTargenting) async {
    Response? response;
    if (accessTargenting == 3) {
      response = await clientDio.get("${url}percentageclientsorganization");
    } else if (accessTargenting == 1) {
      response = await clientDio.get("${url}percentageclients/$codeProvider");
    } else {
      response = await clientDio.get("${url}percentageproviderbyclients/$codeProvider");
    }
    try {
      List list = response.data as List;
      return list.map((json) => PercentageClientsModel.fromJson(json)).toList();
    } catch (e) {
      print("Error return Stores Model Mapper: $e");
    }
  }

  getPercentageProviders() async {
    Response? response;
    try {
      response = await clientDio.get("${url}percentageprovidersorganization");
      List list = response.data as List;
      return list.map((json) => PercentageClientsModel.fromJson(json)).toList();
    } catch (e) {
      print("Error return Stores Model Mapper: $e");
    }
  }

  getTotalValueClients(int? codeProvider, int? accessTargeting) async {
    Response? response;
    if (accessTargeting == 3) {
      response = await clientDio.get("${url}stores");
    } else if (accessTargeting == 1) {
      response = await clientDio.get("${url}storesbyprovider/$codeProvider");
    } else {
      response = await clientDio.get("${url}providersconsult/$codeProvider");
    }
    try {
      List list = response.data as List;

      // List<BarChartGroupData> barGroups = [];
      // print(list);

      // for (int i = 0; i < 10; i++) {
      //   final teste = BarChartGroupData(
      //     x: i + 1,
      //     barRods: [
      //       BarChartRodData(
      //         toY: (double.parse(list[i]["valorTotal"].replaceAll(".", "").replaceAll(",", ""))) / 100,
      //       )
      //     ],
      //     showingTooltipIndicators: [0],
      //   );
      //   barGroups.add(teste);
      // }
      return list.map((json) => TotalValueClients.fromJson(json)).toList();
    } catch (e) {
      print("Error return Stores Model Mapper: $e");
    }
  }

  getTotalValueProducts(int? codeProvider) async {
    Response? response;
    try {
      if (codeProvider == 0) {
        response = await clientDio.get("${url}suppliersinvoicing");
        List list = response.data as List;
        return list.map((json) => TotalValueClients.fromJson(json)).toList();
      } else {
        response = await clientDio.get("${url}merchandiseprovider/$codeProvider");
        List list = response.data as List;
        return list.map((json) => ProductModel.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error return Stores Model Mapper: $e");
    }
  }

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          colorPrimary,
          colorSecondary,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
