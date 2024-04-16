import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:profair/provider/appwriter.dart';
import 'package:profair/src/models/graph_clients.dart';
import 'package:profair/src/models/login_model.dart';
import 'package:profair/src/models/value_minute_graph.dart';
import 'package:profair/src/repositories/buyers_model.dart';
import 'package:profair/src/repositories/categories_icon.dart';
import 'package:profair/src/repositories/information_model.dart';
import 'package:profair/src/repositories/notice_model.dart';
import 'package:profair/src/repositories/requests_stores_model.dart';
import 'package:profair/src/views/home/home_repository.dart';
import 'package:profair/src/repositories/recipe_model.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ValueNotifier<StateApp> {
  List<CategoriesIcon> categories = [];
  List<NoticeModel> notices = [];
  List<RequestsStoresModel> requestStores = [];
  List<RecipeModel> shared = [];
  List<RecipeModel> stores = [];
  List<BuyersModel> buyers = [];
  List<InformationModel> information = [];
  List<GraphClients> chartClient = [];
  List<ValueMinutesGraph> listValueMinute = [];
  DocumentList? balance;
  DocumentList? alerts;
  double? valueFair;
  LoginModel? data;
  List<LoginModel>? moreData;

  final stateValueFair = ValueNotifier<StateApp>(StateApp.start);
  final stateAlert = ValueNotifier<StateApp>(StateApp.start);
  final stateChartPorMinute = ValueNotifier<StateApp>(StateApp.start);
  final stateBalance = ValueNotifier<StateApp>(StateApp.start);
  final stateCategories = ValueNotifier<StateApp>(StateApp.start);
  final stateBuyers = ValueNotifier<StateApp>(StateApp.start);
  final stateStore = ValueNotifier<StateApp>(StateApp.start);
  final stateData = ValueNotifier<StateApp>(StateApp.start);
  final stateChartClients = ValueNotifier<StateApp>(StateApp.start);
  final stateNotices = ValueNotifier<StateApp>(StateApp.start);
  final stateNoticesAppWrite = ValueNotifier<StateApp>(StateApp.start);
  final stateShared = ValueNotifier<StateApp>(StateApp.start);
  final stateInformationTeste = ValueNotifier<StateApp>(StateApp.start);
  final stateRequestsStore = ValueNotifier<StateApp>(StateApp.start);
  final HomeRepository _homeRepository;
  DocumentList? documents;

  HomeController(super.value, this._homeRepository);

  Future<LoginModel?> findData() async {
    stateData.value = StateApp.loading;
    try {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final code = sharedPreferences.getString("codacesso");
      moreData = await _homeRepository.getData({"codacesso": code});
      inspect(moreData);
      data = moreData![0];

      if (data == false || data == null) {
        logout();
      } else {
        await findLastTradings(data!.codCompany);
        getCategories();
        if (data!.accessTargeting == 3) {
          findBuyers();
        }
        stateData.value = StateApp.success;
      }
    } catch (e) {
      print("Error Find Data: $e");
      stateData.value = StateApp.error;
      logout();
    }
    return null;
  }

  Future<LoginModel?> findClient(String id) async {
    stateStore.value = StateApp.loading;
    try {
      return await _homeRepository.getClient(id);
    } catch (e) {
      stateStore.value = StateApp.error;
    }
    return null;
  }

  Future<double> findValueFair() async {
    stateValueFair.value = StateApp.loading;
    try {
      valueFair = await _homeRepository.getValueFair();
      stateValueFair.value = StateApp.success;
    } catch (e) {
      stateValueFair.value = StateApp.error;
    }
    return 0.0;
  }

  Future<double> findValueFairTimeCurrent() async {
    valueFair = await _homeRepository.getValueFair();
    stateValueFair.value = StateApp.loading;
    stateValueFair.value = StateApp.success;
    return 0.0;
  }

  Future findChartTimeCurrent() async {
    try {
      chartClient = await _homeRepository.getChartClients();
      stateChartClients.value = StateApp.loading;
      stateChartClients.value = StateApp.success;
    } catch (e) {
      stateChartClients.value = StateApp.error;
    }
  }

  Future findChartPorMinuteTimeCurrent() async {
    try {
      listValueMinute = await _homeRepository.getChartPorMinute();
      stateChartPorMinute.value = StateApp.loading;
      stateChartPorMinute.value = StateApp.success;
    } catch (e) {
      stateChartPorMinute.value = StateApp.error;
    }
  }

  Future findInformationHomeTimeCurrent() async {
    try {
      information = await _homeRepository.getInformation();
      stateInformationTeste.value = StateApp.loading;
      stateInformationTeste.value = StateApp.success;
    } catch (e) {
      stateInformationTeste.value = StateApp.error;
    }
  }

  Future<LoginModel?> findBuyers() async {
    stateBuyers.value = StateApp.loading;
    try {
      buyers = await _homeRepository.getBuyers();
      stateBuyers.value = StateApp.success;
    } catch (e) {
      stateBuyers.value = StateApp.error;
    }
    return null;
  }

  Future<LoginModel?> findBuyersTimeCurrent() async {
    try {
      buyers = await _homeRepository.getBuyers();
      stateBuyers.value = StateApp.loading;
      stateBuyers.value = StateApp.success;
    } catch (e) {
      stateBuyers.value = StateApp.error;
    }
    return null;
  }

  Future getCategories() async {
    stateCategories.value = StateApp.loading;
    try {
      categories = await _homeRepository.getCategoriesss(data!.accessTargeting!);
      stateCategories.value = StateApp.success;
    } catch (e) {
      stateCategories.value = StateApp.error;
    }
  }

  Future findNotices() async {
    stateNotices.value = StateApp.loading;
    try {
      notices = await _homeRepository.getNotices();
      print("Notices: ${notices}");
      stateNotices.value = StateApp.success;
    } catch (e) {
      stateNotices.value = StateApp.error;
    }
  }

  Future getShared() async {
    stateShared.value = StateApp.loading;
    try {
      shared = await _homeRepository.getSharedHome();
      stateShared.value = StateApp.success;
    } catch (e) {
      stateShared.value = StateApp.error;
    }
  }

  Future findChart() async {
    stateChartClients.value = StateApp.loading;
    try {
      chartClient = await _homeRepository.getChartClients();
      print("Chart Client: ${chartClient}");

      stateChartClients.value = StateApp.success;
    } catch (e) {
      stateChartClients.value = StateApp.error;
    }
  }

  Future findChartPorMinute() async {
    stateChartPorMinute.value = StateApp.loading;
    try {
      listValueMinute = await _homeRepository.getChartPorMinute();
      print("List Value Limit: ${listValueMinute}");

      stateChartPorMinute.value = StateApp.success;
    } catch (e) {
      stateChartPorMinute.value = StateApp.error;
    }
  }

  Future findInformationHome() async {
    stateInformationTeste.value = StateApp.loading;
    try {
      information = await _homeRepository.getInformation();
      print("Information: ${information}");

      stateInformationTeste.value = StateApp.success;
    } catch (e) {
      stateInformationTeste.value = StateApp.error;
    }
  }

  Future findLastTradings(int? codeProvider) async {
    stateRequestsStore.value = StateApp.loading;
    try {
      requestStores = await _homeRepository.getLastTradings(codeProvider);
    } catch (e) {
      stateRequestsStore.value = StateApp.error;
    }
    stateRequestsStore.value = StateApp.success;
  }

  findDoc(AppWrite appWriteSend) async {
    stateNoticesAppWrite.value = StateApp.loading;
    try {
      documents = await appWriteSend.getDocuments("64e4fd339e70e9e3f1ca", null);
      balance = await appWriteSend.getDocuments("64e8e98ad3b5d85caf4e", null);

      stateNoticesAppWrite.value = StateApp.success;
    } catch (e) {
      print("Error Find Documents $e");
      stateNoticesAppWrite.value = StateApp.error;
    }
  }

  String formatCurrency(double amount) {
    String formattedAmount = amount.toStringAsFixed(2);
    formattedAmount = formattedAmount.replaceAll('.', ',');
    List<String> parts = formattedAmount.split(',');
    String integerPart = parts[0];
    String decimalPart = parts[1];

    String formattedIntegerPart = '';
    for (int i = integerPart.length - 1, count = 0; i >= 0; i--, count++) {
      if (count != 0 && count % 3 == 0) {
        formattedIntegerPart = ".$formattedIntegerPart";
      }
      formattedIntegerPart = integerPart[i] + formattedIntegerPart;
    }

    return 'R\$$formattedIntegerPart,$decimalPart';
  }

  Future getNoticeAppWrite(AppWrite appWriteSend) async {
    stateNoticesAppWrite.value = StateApp.loading;
    try {
      final subscription = await appWriteSend.listDocumentsRealTime();
      subscription.stream.listen((response) {
        if (response.channels[1].toString().contains("64ea1ced75f87c91474e")) {
          final indexAlerts =
              alerts!.documents.indexWhere((item) => (item.$id).toString() == response.payload["\$id"].toString());
          if (indexAlerts != -1) {
            // stateAlert.value = StateApp.loading;
            // alerts!.documents[indexAlerts].data["title"] = response.payload["title"];
            // alerts!.documents[indexAlerts].data["time"] = response.payload["time"];
            // alerts!.documents[indexAlerts].data["description"] = response.payload["description"];
            // alerts!.documents[indexAlerts].data["priority"] = response.payload["priority"];
            // stateAlert.value = StateApp.success;
          }
        } else if (response.channels[1].toString().contains("64f3970485c4cdaaac64")) {
          findValueFairTimeCurrent();
          findChartTimeCurrent();
          findChartPorMinuteTimeCurrent();
          findInformationHomeTimeCurrent();
          findBuyersTimeCurrent();
        }

        final index =
            documents!.documents.indexWhere((item) => (item.$id).toString() == response.payload["\$id"].toString());
        if (index != -1) {
          stateNoticesAppWrite.value = StateApp.loading;
          documents!.documents[index].data["title"] = response.payload["title"];
          documents!.documents[index].data["content"] = response.payload["content"];
          documents!.documents[index].data["color"] = response.payload["color"];
          documents!.documents[index].data["stamp"] = response.payload["stamp"];
          documents!.documents[index].data["colorStamp"] = response.payload["colorStamp"];
          stateNoticesAppWrite.value = StateApp.success;
        }
      });
    } catch (e) {
      print("Error Init Real Time:f $e");
      stateNoticesAppWrite.value = StateApp.error;
    }
  }

  Future logout() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    return;
  }

  Future findAlert(AppWrite appWriteSend) async {
    stateAlert.value = StateApp.loading;
    try {
      alerts = await appWriteSend.getDocuments("64ea1ced75f87c91474e", [Query.orderDesc("priority")]);

      stateAlert.value = StateApp.success;
    } catch (e) {
      stateAlert.value = StateApp.error;
    }
  }
}
