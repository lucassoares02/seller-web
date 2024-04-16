import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:profair/src/views/users/user_model.dart';

class UserRepository {
  final Dio clientDio = Dio();
  final String url = "https://profair.click/";

  getUsers() async {
    try {
      final response = await clientDio.get("${url}getallusersorg");

      List list = response.data as List;
      return list.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint("Error return Negotiation Model Mapper: $e");
    }
  }

  getUsersProvider() async {
    try {
      final response = await clientDio.get("${url}getallusersprovider");

      List list = response.data as List;
      return list.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint("Error return Negotiation Model Mapper: $e");
    }
  }

  getUsersAssociate() async {
    try {
      final response = await clientDio.get("${url}getallusersassociate");

      List list = response.data as List;
      return list.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint("Error return Negotiation Model Mapper: $e");
    }
  }
}
