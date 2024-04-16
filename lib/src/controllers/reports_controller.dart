import 'dart:developer';

import 'package:profair/src/models/product_model.dart';
import 'package:profair/src/models/total_value_clients.dart';
import 'package:profair/src/repositories/percentage_clients_model.dart';
import 'package:profair/src/repositories/reports_repository.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';

class ReportsController extends ValueNotifier<StateApp> {
  // List<TotalValueClients> reportsTotalClient = [];
  List<TotalValueClients> reportsTotalClient = [];
  List<ProductModel> reportsTotalProducts = [];
  List<TotalValueClients> reportsTotalProvider = [];

  PercentageClientsModel? percentageClients;
  PercentageClientsModel? percentageProviders;

  final stateReports = ValueNotifier<StateApp>(StateApp.start);
  final stateReportsProducts = ValueNotifier<StateApp>(StateApp.start);
  final statePercentageClients = ValueNotifier<StateApp>(StateApp.start);
  final statePercentageProviders = ValueNotifier<StateApp>(StateApp.start);

  final ReportsRepository _reportsRepository;

  ReportsController(super.value, this._reportsRepository);

  Future findPercentageClients(int? codeProvider, int? accessTargeting) async {
    statePercentageProviders.value = StateApp.loading;
    statePercentageClients.value = StateApp.loading;
    try {
      List<PercentageClientsModel> percentage = await _reportsRepository.getPercentageClients(codeProvider, accessTargeting);
      if (accessTargeting == 1 || accessTargeting == 3) {
        statePercentageProviders.value = StateApp.loading;

        List<PercentageClientsModel> percentageP = await _reportsRepository.getPercentageProviders();
        percentageProviders = percentageP[0];
        statePercentageProviders.value = StateApp.success;
      }
      percentageClients = percentage[0];
      statePercentageClients.value = StateApp.success;
      statePercentageProviders.value = StateApp.success;
    } catch (e) {
      print("Error Controller List Attractions: $e");
      statePercentageProviders.value = StateApp.error;
      statePercentageClients.value = StateApp.error;
    }
  }

  Future findTotalValueClients(int? codeProvider, int? accessTargeting) async {
    stateReports.value = StateApp.loading;
    try {
      reportsTotalClient = await _reportsRepository.getTotalValueClients(codeProvider, accessTargeting);

      stateReports.value = StateApp.success;
    } catch (e) {
      print("Error Controller List Attractions: $e");
      stateReports.value = StateApp.error;
    }
  }

  Future findTotalValueProducts(int? codeProvider, int accessTargeting) async {
    stateReportsProducts.value = StateApp.loading;
    try {
      if (accessTargeting == 3) {
        reportsTotalProvider = await _reportsRepository.getTotalValueProducts(codeProvider);
      } else {
        reportsTotalProducts = await _reportsRepository.getTotalValueProducts(codeProvider);
        inspect(reportsTotalProducts);
      }

      stateReportsProducts.value = StateApp.success;
    } catch (e) {
      print("Error Controller List Reports Products: $e");
      stateReportsProducts.value = StateApp.error;
    }
  }
}
