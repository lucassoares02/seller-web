import 'package:appwrite/models.dart';
import 'package:profair/src/models/active_model.dart';
import 'package:profair/src/models/details_walllet.dart';
import 'package:profair/src/models/value_minute_graph.dart';
import 'package:profair/src/views/home/home_repository.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ValueNotifier<StateApp> {
  List<ActiveModel>? actives = [];
  List<DetailsWallet>? detailsWallet = [];
  List<DataLineGraph>? historic = [];
  List<DataLineGraph>? historicAll = [];
  List<List<DataLineGraph>> historicListAll = [];
  double maxValue = 0;
  bool valueDropSelected = true;

  final stateActives = ValueNotifier<StateApp>(StateApp.start);
  final stateDetails = ValueNotifier<StateApp>(StateApp.start);
  final stateHistoric = ValueNotifier<StateApp>(StateApp.start);
  final stateHistoricAll = ValueNotifier<StateApp>(StateApp.start);
  final HomeRepository _homeRepository;
  DocumentList? documents;

  HomeController(super.value, this._homeRepository);

  Future<ActiveModel?> findActives() async {
    stateActives.value = StateApp.loading;
    try {
      actives = await _homeRepository.getActives();
      stateActives.value = StateApp.success;
    } catch (e) {
      stateActives.value = StateApp.error;
    }
    return null;
  }

  Future<DetailsWallet?> findDetails(bool active) async {
    stateDetails.value = StateApp.loading;
    try {
      detailsWallet = await _homeRepository.getResume(active);
      stateDetails.value = StateApp.success;
    } catch (e) {
      stateDetails.value = StateApp.error;
    }
    return null;
  }

  Future<DetailsWallet?> findHistoric(bool active) async {
    stateHistoric.value = StateApp.loading;
    try {
      historic = await _homeRepository.getHistoric(active);
      if (historic != null) {
        for (var element in historic!) {
          if (maxValue < element.close!) maxValue = element.close!;
        }
      }
      stateHistoric.value = StateApp.success;
    } catch (e) {
      stateHistoric.value = StateApp.error;
    }
    return null;
  }

  Future<DetailsWallet?> findHistoricAllActions(bool active) async {
    valueDropSelected = active;
    SharedPreferences sharePref = await SharedPreferences.getInstance();
    sharePref.setBool("selected", active);
    stateHistoricAll.value = StateApp.loading;
    historicListAll = [];
    try {
      historicAll = await _homeRepository.getHistoricAllActions(active);
      historicAll!.sort((a, b) => a.id!.compareTo(b.id!));
      List<DataLineGraph> a = [];
      for (var i = 0; i < historicAll!.length; i++) {
        if (i != 0 && historicAll![i].id == a[0].id) {
          a.add(
            DataLineGraph(
              id: historicAll![i].id,
              data: historicAll![i].data,
              close: historicAll![i].close,
            ),
          );
        } else if (i != 0) {
          historicListAll.add(a);
          a = [];
          a.add(DataLineGraph(
            id: historicAll![i].id,
            data: historicAll![i].data,
            close: historicAll![i].close,
          ));
        } else {
          a.add(DataLineGraph(
            id: historicAll![i].id,
            data: historicAll![i].data,
            close: historicAll![i].close,
          ));
        }
      }
      stateHistoricAll.value = StateApp.success;
    } catch (e) {
      print("Find Historic All Actions (Home Controller) Error: $e");
      stateHistoricAll.value = StateApp.error;
    }
    return null;
  }
}
