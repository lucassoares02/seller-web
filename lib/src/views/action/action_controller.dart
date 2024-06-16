import 'package:appwrite/models.dart';
import 'package:profair/src/models/active_model.dart';
import 'package:profair/src/models/historic_model.dart';
import 'package:profair/src/views/action/action_repository.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';

class ActionController extends ValueNotifier<StateApp> {
  List<ActiveModel>? actives = [];
  List<HistoricModel>? historic = [];

  final stateActives = ValueNotifier<StateApp>(StateApp.start);
  final stateHistoric = ValueNotifier<StateApp>(StateApp.start);
  final ActionRepository _actionRepository;
  DocumentList? documents;
  double maxValue = 0;

  ActionController(super.value, this._actionRepository);

  Future<ActiveModel?> findActives() async {
    stateActives.value = StateApp.loading;
    try {
      actives = await _actionRepository.getActives();
      stateActives.value = StateApp.success;
    } catch (e) {
      stateActives.value = StateApp.error;
    }
    return null;
  }

  Future<HistoricModel?> findHistoric(String? active) async {
    stateHistoric.value = StateApp.loading;
    try {
      historic = await _actionRepository.getHistoric(active);
      if (historic != null) {
        for (var element in historic!) {
          if (maxValue < element.close!) {
            maxValue = element.close!;
          }
        }
      }
      stateHistoric.value = StateApp.success;
    } catch (e) {
      stateHistoric.value = StateApp.error;
    }
    return null;
  }
}
