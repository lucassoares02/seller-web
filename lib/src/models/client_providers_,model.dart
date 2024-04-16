import 'package:profair/src/models/providers_model.dart';

class ClientProvidersModel {
  int? code;
  String? client;
  String? value;
  List<ProvidersModel>? providers = [];

  ClientProvidersModel({this.code, this.client, this.value, this.providers});
}
