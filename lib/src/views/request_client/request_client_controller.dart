import 'package:fluttertoast/fluttertoast.dart';
import 'package:profair/src/models/nogotiation_model.dart';
import 'package:profair/src/repositories/details_provider.dart';
import 'package:profair/src/repositories/products_provider_model.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/request_client/request_client_repository.dart';

class RequestClientController extends ValueNotifier<StateApp> {
  List<NegotiationModel> negotiations = [];
  List<ProductsProviderModel> products = [];
  DetailsProvider? detailsProvider;

  final stateNegotiation = ValueNotifier<StateApp>(StateApp.start);
  final stateMerchandise = ValueNotifier<StateApp>(StateApp.start);
  final stateDetailsProvider = ValueNotifier<StateApp>(StateApp.start);
  int sortInt = 0;

  final RequestClientRepository requestClientRepository;

  RequestClientController(super.value, this.requestClientRepository);

  Future findNegotiation(int? codeBranch, int? codeProvider, double valueTotal) async {
    stateNegotiation.value = StateApp.loading;
    try {
      negotiations = await requestClientRepository.getNegotiation(codeBranch!, codeProvider!);
      negotiations.insert(0, NegotiationModel(negotiation: 0, title: "Todas", confirm: 0, checked: false, value: valueTotal));
      stateNegotiation.value = StateApp.success;
    } catch (e) {
      stateNegotiation.value = StateApp.error;
    }
  }

  Future findMerchandise(int? codeBranch, int? codeProvider, int? codeTrading) async {
    stateMerchandise.value = StateApp.loading;
    try {
      products = await requestClientRepository.getMerchandises(codeBranch!, codeProvider!, codeTrading!);
      stateMerchandise.value = StateApp.success;
    } catch (e) {
      stateMerchandise.value = StateApp.error;
    }
  }

  Future findDetailsProvider(int? codeProvider) async {
    stateDetailsProvider.value = StateApp.loading;
    try {
      detailsProvider = await requestClientRepository.getDetailsProvider(codeProvider!);
      stateDetailsProvider.value = StateApp.success;
    } catch (e) {
      stateDetailsProvider.value = StateApp.error;
    }
  }

  sort() async {
    print("sort");
    stateMerchandise.value = StateApp.loading;
    String? message = "";
    try {
      if (sortInt == 0) {
        products.sort(((a, b) => b.totalValue!.compareTo(a.totalValue!)));
        message = "Ordenado por valor total de vendas!";
      } else if (sortInt == 1) {
        products.sort(((a, b) => int.parse(b.totalVolume!) - int.parse(a.totalVolume!)));
        message = "Ordenado volume vendido!";
      } else if (sortInt == 2) {
        products.sort(((a, b) => a.nameProduct!.compareTo(b.nameProduct!)));
        message = "Ordenado por ordem alfabética!";
      }
      if (sortInt == 2) {
        sortInt = 0;
      } else {
        sortInt += 1;
      }
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      stateMerchandise.value = StateApp.success;
    } catch (e) {
      print("Error Sort Stores: $e");
      stateMerchandise.value = StateApp.error;
    }
  }
}
