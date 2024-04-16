import 'package:profair/src/models/nogotiation_model.dart';

import 'package:profair/src/repositories/negotiation_repository.dart';
import 'package:profair/src/repositories/products_provider_model.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';

class NegotiationController extends ValueNotifier<StateApp> {
  List<NegotiationModel> negotiations = [];
  List<ProductsProviderModel> products = [];

  final stateNegotiations = ValueNotifier<StateApp>(StateApp.start);
  final stateMerchandise = ValueNotifier<StateApp>(StateApp.start);

  final NegotiationRepository _negotiationsRepository;

  NegotiationController(super.value, this._negotiationsRepository);

  Future findNegotiations(int? codeBranch, int? codeProvider) async {
    stateNegotiations.value = StateApp.loading;
    try {
      negotiations = await _negotiationsRepository.getNegotiations(codeBranch, codeProvider);
      stateNegotiations.value = StateApp.success;
    } catch (e) {
      stateNegotiations.value = StateApp.error;
    }
  }

  Future findMerchandise(int? codeProvider) async {
    stateMerchandise.value = StateApp.loading;
    try {
      products = await _negotiationsRepository.getMerchandise(codeProvider);
      stateMerchandise.value = StateApp.success;
    } catch (e) {
      stateMerchandise.value = StateApp.error;
    }
  }
}
