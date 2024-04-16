import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SettingsRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";

  getRequestsStores(int? codeProvider, int? userCode) async {
    Response? response;
    try {} catch (e) {
      print("Error return Settings Mapper: $e");
    }
  }
}
