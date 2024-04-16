import 'dart:developer';

import 'package:profair/src/models/client_providers_,model.dart';
import 'package:profair/src/models/providers_model.dart';
import 'package:profair/src/repositories/download_repository.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';

class DownloadController extends ValueNotifier<StateApp> {
  DownloadController(super.value, this._downloadRepository);

  final DownloadRepository _downloadRepository;

  ValueNotifier<StateApp> stateExport = ValueNotifier<StateApp>(StateApp.start);
  ValueNotifier<StateApp> stateListProviders = ValueNotifier<StateApp>(StateApp.start);
  List<ClientProvidersModel> clientProviders = [];
  List<ClientProvidersModel> clientProvidersBackup = [];

  Future exportData() async {
    print("Iniciando exportação do arquivo");
    stateExport.value = StateApp.loading;

    try {
      final response = await _downloadRepository.download();

      stateExport.value = StateApp.success;
      print("Exportação Finalizada!");
    } catch (e) {
      print("Problemas na exportação!");
      print("$e");
      stateExport.value = StateApp.error;
    }
  }

  Future exportDataClient(int codeClient) async {
    print("Iniciando exportação do arquivo");
    stateExport.value = StateApp.loading;
    try {
      final response = await _downloadRepository.downloadClient(codeClient);
      stateExport.value = StateApp.success;
      print("Exportação Finalizada!");
    } catch (e) {
      print("Problemas na exportação!");
      print("$e");
      stateExport.value = StateApp.error;
    }
  }

  Future exportDataClientProvider(int codeClient, int codeProvider) async {
    print("Iniciando exportação do arquivo");
    stateExport.value = StateApp.loading;
    try {
      final response = await _downloadRepository.downloadClientProvider(codeClient, codeProvider);
      stateExport.value = StateApp.success;
      print("Exportação Finalizada!");
    } catch (e) {
      print("Problemas na exportação!");
      print("$e");
      stateExport.value = StateApp.error;
    }
  }

  Future listProviders(int codeClient, String nomeClient, String value) async {
    print("Iniciando Lista de Fornecedores");
    stateListProviders.value = StateApp.loading;

    try {
      List<ProvidersModel>? response = await _downloadRepository.getProvidersByCompany(codeClient);

      clientProviders.add(ClientProvidersModel(
          code: codeClient, value: value, client: "$codeClient - $nomeClient", providers: response));
      clientProvidersBackup.add(ClientProvidersModel(
          code: codeClient, value: value, client: "$codeClient - $nomeClient", providers: response));
    } catch (e) {
      print("List Providers (Item Donwload Client) Error: $e");
      stateListProviders.value = StateApp.error;
    }
  }

  search(String? value, int index) async {
    stateListProviders.value = StateApp.loading;
    try {
      if (value! == "") {
        clientProviders[index].providers = clientProvidersBackup[index].providers;
      }
      clientProviders[index].providers = clientProvidersBackup[index].providers?.where((item) {
        return item.nameProvider!.toLowerCase().contains(value.toLowerCase());
      }).toList();

      stateListProviders.value = StateApp.success;
    } catch (e) {
      print("Error search Requests Stores: $e");
      stateListProviders.value = StateApp.error;
    }
  }
}
