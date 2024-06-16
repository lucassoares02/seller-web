import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:profair/src/models/active_model.dart';
import 'package:profair/src/models/historic_model.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/wallet/wallet_repository.dart';

class WalletController extends ValueNotifier<StateApp> {
  List<ActiveModel>? actives = [];
  List<HistoricModel>? historic = [];

  final stateActives = ValueNotifier<StateApp>(StateApp.start);
  final stateFilter = ValueNotifier<StateApp>(StateApp.start);
  final WalletRepository _walletRepository;
  DocumentList? documents;

  WalletController(super.value, this._walletRepository);

  Future<ActiveModel?> findActives(bool active) async {
    stateActives.value = StateApp.loading;
    try {
      actives = await _walletRepository.getActives(active);
      stateActives.value = StateApp.success;
    } catch (e) {
      stateActives.value = StateApp.error;
    }
    return null;
  }

  sort({int type = 0}) async {
    stateActives.value = StateApp.loading;
    String? message = "";
    try {
      if (type == 0) {
        actives!.sort(((a, b) => b.valorizacao!.compareTo(a.valorizacao!)));
        message = "Ordenado por ordem Valorização!";
      } else if (type == 1) {
        actives!.sort(((a, b) => b.renda!.compareTo(a.renda!)));
        message = "Ordenado por ordem Valor Investido!";
      } else if (type == 2) {
        actives!.sort(((a, b) => b.valorAtivo!.compareTo(a.valorAtivo!)));
        message = "Ordenado por ordem Valor Ativo!";
      }

      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);

      stateActives.value = StateApp.success;
    } catch (e) {
      print("Error Sort Stores: $e");
      stateActives.value = StateApp.error;
    }
  }
}
