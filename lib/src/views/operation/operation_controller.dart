import 'package:appwrite/models.dart';
import 'package:profair/src/models/active_model.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/operation/operation_repository.dart';

class OperationController extends ValueNotifier<StateApp> {
  List<ActiveModel>? actives = [];

  final stateActives = ValueNotifier<StateApp>(StateApp.start);
  final OperationRepository _homeRepository;
  DocumentList? documents;

  OperationController(super.value, this._homeRepository);

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
}
