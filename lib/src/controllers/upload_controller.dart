import 'dart:convert';
import 'dart:developer';

import 'package:profair/src/models/clients_upload_model.dart';
import 'package:profair/src/models/company_upload_model.dart';
import 'package:profair/src/models/login_model.dart';
import 'package:profair/src/models/merchandise_model.dart';
import 'package:profair/src/models/negotiation_upload_model.dart';
import 'package:profair/src/repositories/upload_repository.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';

class UploadController extends ValueNotifier<StateApp> {
  UploadController(super.value, this._uploadRepository);

  final UploadRepository _uploadRepository;
  final stateUpload = ValueNotifier<StateApp>(StateApp.start);
  final stateSendindUploadProvider = ValueNotifier<StateApp>(StateApp.start);
  final stateSendindUploadPeople = ValueNotifier<StateApp>(StateApp.start);
  final stateSendindUploadMerchandise = ValueNotifier<StateApp>(StateApp.start);
  final stateSendindUploadNegotiaton = ValueNotifier<StateApp>(StateApp.start);
  ValueNotifier<StateApp> stateSendData = ValueNotifier<StateApp>(StateApp.start);

  ValueNotifier<bool> finishUploadClients = ValueNotifier(false);
  ValueNotifier<bool> finishUploadPeople = ValueNotifier(false);
  ValueNotifier<bool> finishUploadMerchandise = ValueNotifier(false);
  ValueNotifier<bool> finishUploadNegotiation = ValueNotifier(false);

  List<CompanyUpload>? clientsUpload = [];
  List<CompanyUpload>? clientsUploadBackup = [];

  List<ClientsUpload>? peopleUpload = [];
  List<ClientsUpload> peopleUploadBackup = [];

  List<MerchandiseUpload>? merchandiseUpload = [];
  List<MerchandiseUpload> renew = [];

  List<NegoatiationUploadModel>? negotiationUpload = [];
  List<NegoatiationUploadModel>? negotiationUploadBackup = [];

  LoginModel? dataUser;

  Future sendUploadProvider() async {
    stateSendindUploadProvider.value = StateApp.loading;

    try {
      clientsUploadBackup = [...clientsUpload!];
      int j = 0;
      int lengthProviders = clientsUploadBackup!.length;
      for (j; j < lengthProviders; j++) {
        stateSendData.value = StateApp.loading;
        Map<String?, String?> data = {
          "codForn": clientsUploadBackup![j].code.toString(),
          "nomeForn": capitalizeWords(clientsUploadBackup![j].name.toString()),
          "razaoForn": capitalizeWords(clientsUploadBackup![j].social.toString()),
          "cnpjForn": clientsUploadBackup![j].document.toString(),
          "telForn": clientsUploadBackup![j].phone.toString(),
          "type": clientsUploadBackup![j].type.toString(),
          "categoria": clientsUploadBackup![j].category.toString(),
          "codComprFornecedor": clientsUploadBackup![j].category.toString(),
          "image": "image"
        };

        print(data);
        final response = await _uploadRepository.uploadProvider(data);

        if (response != 400) {
          clientsUpload!.remove(clientsUploadBackup![j]);
        }
        stateSendData.value = StateApp.success;
      }
      stateSendindUploadProvider.value = StateApp.success;
      finishUploadClients.value = true;
    } catch (e) {
      stateSendData.value = StateApp.error;
      stateSendindUploadProvider.value = StateApp.error;
      return false;
    }
  }

  Future sendUploadPeople() async {
    stateSendindUploadPeople.value = StateApp.loading;

    try {
      peopleUploadBackup = [...peopleUpload!];
      int j = 0;
      int lengthMerchandise = peopleUploadBackup.length;
      for (j; j < lengthMerchandise; j++) {
        stateSendData.value = StateApp.loading;
        Map<String?, String?> data = {
          "cod": peopleUploadBackup[j].code.toString(),
          "nome": peopleUploadBackup[j].name.toString(),
          "empresa": peopleUploadBackup[j].company.toString(),
          "cpf": peopleUploadBackup[j].document.toString(),
          "tel": peopleUploadBackup[j].phone.toString(),
          "hash": peopleUploadBackup[j].hash.toString(),
          "type": peopleUploadBackup[j].type.toString(),
          "email": peopleUploadBackup[j].email.toString(),
        };
        print(data);
        final response = await _uploadRepository.uploadPeople(data);

        if (response != 400) {
          peopleUpload!.remove(peopleUploadBackup[j]);
        }
        stateSendData.value = StateApp.success;
      }
      stateSendindUploadPeople.value = StateApp.success;
      finishUploadPeople.value = true;
    } catch (e) {
      stateSendData.value = StateApp.error;
      stateSendindUploadPeople.value = StateApp.error;
      return false;
    }
  }

  Future sendUploadPeopleClients() async {
    stateSendindUploadPeople.value = StateApp.loading;

    try {
      int k = 0;
      int lengthClient = jsonLojistas.length;

      for (k; k < lengthClient; k++) {
        stateSendData.value = StateApp.loading;
        ClientsUpload? client = buscarClientePorCodigo(jsonLojistas[k]["lojista"]);
        if (client != null) {
          Map<String?, String?> data = {
            "cod": client.code.toString(),
            "nome": capitalizeWords(client.name.toString()),
            "empresa": jsonLojistas[k]["loja"].toString(),
            "cpf": client.document.toString(),
            "tel": client.phone.toString(),
            "hash": client.hash.toString(),
            "type": client.type.toString(),
            "email": client.email.toString(),
          };

          // print(data);
          final response = await _uploadRepository.uploadPeople(data);

          if (response != 400) {
            peopleUpload!.remove(client);
          }
          stateSendData.value = StateApp.success;
        }
      }
      stateSendindUploadPeople.value = StateApp.success;
      finishUploadPeople.value = true;
    } catch (e) {
      stateSendData.value = StateApp.error;
      stateSendindUploadPeople.value = StateApp.error;
      print("Error Upload client: $e");
      return false;
    }
  }

  ClientsUpload? buscarClientePorCodigo(int codigo) {
    for (var cliente in peopleUploadBackup) {
      if (int.parse(cliente.code!) == codigo) {
        return cliente;
      }
    }
    print("codigo");
    print(codigo);
    // Retorna null se o cliente com o código especificado não for encontrado
    return null;
  }

  Future sendUploadMerchandise() async {
    stateSendindUploadMerchandise.value = StateApp.loading;

    try {
      renew = [...merchandiseUpload!];
      int j = 0;
      int lengthMerchandise = renew.length;
      for (j; j < lengthMerchandise; j++) {
        stateSendData.value = StateApp.loading;
        Map<String?, String?> data = {
          "codMercadoria": renew[j].code.toString(),
          "nomeMercadoria": renew[j].name.toString(),
          "codFornMerc": renew[j].company.toString(),
          "embMercadoria": renew[j].packing.toString(),
          "fatorMerc": renew[j].factor.toString(),
          "precoMercadoria": renew[j].price.toString().replaceAll(",", "."),
          "precoUnit": renew[j].unitPrice.toString().replaceAll(",", "."),
          "barcode": renew[j].barcode.toString(),
          "marca": renew[j].brand.toString(),
          "complemento": renew[j].complement.toString(),
          "erpcode": renew[j].erpcode.toString(),
          "negociacao": renew[j].negociacao.toString(),
        };
        final response = await _uploadRepository.uploadMerchandise(data);

        if (response != 400) {
          merchandiseUpload!.remove(renew[j]);
        }
        stateSendData.value = StateApp.success;
      }
      stateSendindUploadMerchandise.value = StateApp.success;
      finishUploadMerchandise.value = true;
    } catch (e) {
      print("Error import Merchandise: $e");
      stateSendData.value = StateApp.error;
      stateSendindUploadMerchandise.value = StateApp.error;
      return false;
    }
  }

  Future sendUploadNegotiation() async {
    stateSendindUploadNegotiaton.value = StateApp.loading;

    try {
      negotiationUploadBackup = [...negotiationUpload!];
      int j = 0;
      int lengthMerchandise = negotiationUploadBackup!.length;
      for (j; j < lengthMerchandise; j++) {
        stateSendData.value = StateApp.loading;
        Map<String?, String?> data = {
          "codNegociacao": negotiationUploadBackup![j].code.toString(),
          "descNegociacao": capitalizeWords(negotiationUploadBackup![j].name.toString()),
          "codFornNegociacao": negotiationUploadBackup![j].company.toString(),
          "prazo": negotiationUploadBackup![j].prazo.toString(),
          "codNegoErp": negotiationUploadBackup![j].codNegoErp.toString(),
          "observacao": negotiationUploadBackup![j].observacao.toString(),
        };
        // Map<String?, String?> data = {
        //   "codMercadoria": negotiationUploadBackup![j].code,
        //   "codNegociacao": negotiationUploadBackup![j].company,
        // };
        print(data);
        final response = await _uploadRepository.uploadNegotiation(data);
        // final response = await _uploadRepository.uploadRelacionamentoMercadorias(data);

        if (response != 400) {
          negotiationUpload!.remove(negotiationUploadBackup![j]);
        }
        stateSendData.value = StateApp.success;
      }
      stateSendindUploadNegotiaton.value = StateApp.success;
      finishUploadNegotiation.value = true;
    } catch (e) {
      stateSendData.value = StateApp.error;
      stateSendindUploadNegotiaton.value = StateApp.error;
      return false;
    }
  }

  Future uploadCSV(String? type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    try {
      if (result != null) {
        stateUpload.value = StateApp.loading;
        List<List<dynamic>> csvRows = [];

        if (result.files.single.bytes != null) {
          Uint8List csvBytes = result.files.single.bytes!;
          // String csvContent = String.fromCharCodes(csvBytes);
          String csvContent = utf8.decode(csvBytes);

          final csvConverter = CsvToListConverter();
          csvRows = csvConverter.convert(csvContent);

          print(csvRows);
          inspect(csvRows);

          List<dynamic> csvRowsFinal = [];

          int count = 1;
          for (int i = 0; i < csvRows[0].length; i++) {
            if (csvRows[0][i].toString().contains("\n")) {
              final part = csvRows[0][i].toString().split("\n");

              csvRowsFinal.add(part[0]);
              print(part);

              if (part[1] != "") {
                csvRowsFinal.add(part[1]);
                count = 0;
              } else {
                count += 2;
              }
            } else {
              count += 1;
              csvRowsFinal.add(csvRows[0][i]);
            }
          }

          int te = 0;
          int te1 = 1;
          int te2 = 2;
          int te3 = 3;
          int te4 = 4;
          int te5 = 5;
          int te6 = 6;
          int te7 = 7;
          int te8 = 8;
          int te9 = 9;
          int te10 = 10;
          int te11 = 11;
          print("count");
          print(count);
          for (int i = 0; i < csvRowsFinal.length / count; i++) {
            if (type == "company") {
              clientsUpload!.add(
                CompanyUpload(
                  code: csvRowsFinal[te].toString(),
                  name: csvRowsFinal[te1].toString(),
                  social: csvRowsFinal[te2].toString(),
                  document: csvRowsFinal[te3].toString(),
                  category: csvRowsFinal[te4].toString(),
                  type: csvRowsFinal[te5].toString(),
                  consult: csvRowsFinal[te6].toString(),
                  phone: csvRowsFinal[te7].toString(),
                ),
              );
              clientsUploadBackup = [...clientsUpload!];
            } else if (type == "people") {
              peopleUpload!.add(
                ClientsUpload(
                  code: csvRowsFinal[te].toString(),
                  name: csvRowsFinal[te1].toString(),
                  company: csvRowsFinal[te2].toString(),
                  document: csvRowsFinal[te3].toString(),
                  phone: csvRowsFinal[te4].toString(),
                  hash: "${csvRowsFinal[te1]}${csvRowsFinal[te3]}".hashCode.toString(),
                  type: csvRowsFinal[te6].toString(),
                  email:
                      "${csvRowsFinal[te1].toString().toLowerCase().replaceAll(RegExp(r'[^a-zA-Z0-9]'), '.')}@profair.com",
                ),
              );
              peopleUploadBackup = [...peopleUpload!];
            } else if (type == "merchandise") {
              merchandiseUpload!.add(
                MerchandiseUpload(
                  code: csvRowsFinal[te].toString(),
                  name: csvRowsFinal[te1].toString(),
                  company: csvRowsFinal[te2].toString(),
                  factor: csvRowsFinal[te3].toString(),
                  price: csvRowsFinal[te4].toString(),
                  unitPrice: csvRowsFinal[te5].toString(),
                  barcode: csvRowsFinal[te6].toString(),
                  brand: csvRowsFinal[te7].toString(),
                  complement: csvRowsFinal[te8].toString(),
                  erpcode: csvRowsFinal[te9].toString(),
                  negociacao: csvRowsFinal[te10].toString(),
                  packing: csvRowsFinal[te11].toString(),
                ),
              );
              renew = [...merchandiseUpload!];
            } else if (type == "negotiation") {
              negotiationUpload!.add(NegoatiationUploadModel(
                code: csvRowsFinal[te].toString(),
                company: csvRowsFinal[te1].toString(),
                prazo: csvRowsFinal[te2].toString(),
                observacao: csvRowsFinal[te3].toString(),
                codNegoErp: csvRowsFinal[te4].toString(),
                name: csvRowsFinal[te5].toString(),
              ));
              negotiationUploadBackup = [...negotiationUpload!];
            }
            te += count;
            te1 += count;
            te2 += count;
            te3 += count;
            te4 += count;
            te5 += count;
            te6 += count;
            te7 += count;
            te8 += count;
            te9 += count;
            te10 += count;
          }
        }
      }
      stateUpload.value = StateApp.success;
    } catch (e) {
      print("Error import file: $e");
      stateUpload.value = StateApp.error;
    }
  }

  String capitalizeWords(String input) {
    List<String> words = input.toLowerCase().split(' '); // Dividir a string em palavras
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1); // Capitalizar a primeira letra de cada palavra
      }
    }
    return words.join(' '); // Juntar as palavras em uma string novamente
  }

  int encontrarCodigoLoja(int codigoLojista) {
    for (var lojista in jsonLojistas) {
      if (lojista["lojista"] == codigoLojista) {
        return lojista["loja"];
      }
    }
    // Retorna -1 se o código do lojista não for encontrado
    return -1;
  }

  List<Map<String, dynamic>> jsonLojistas = [
    {"lojista": 73, "loja": 101},
    {"lojista": 135, "loja": 102},
    {"lojista": 97, "loja": 110},
    {"lojista": 283, "loja": 110},
    {"lojista": 129, "loja": 111},
    {"lojista": 130, "loja": 113},
    {"lojista": 94, "loja": 116},
    {"lojista": 312, "loja": 116},
    {"lojista": 95, "loja": 117},
    {"lojista": 158, "loja": 117},
    {"lojista": 96, "loja": 119},
    {"lojista": 105, "loja": 120},
    {"lojista": 131, "loja": 122},
    {"lojista": 63, "loja": 125},
    {"lojista": 64, "loja": 125},
    {"lojista": 84, "loja": 125},
    {"lojista": 26, "loja": 130},
    {"lojista": 27, "loja": 130},
    {"lojista": 10, "loja": 134},
    {"lojista": 36, "loja": 134},
    {"lojista": 42, "loja": 134},
    {"lojista": 75, "loja": 134},
    {"lojista": 126, "loja": 134},
    {"lojista": 168, "loja": 134},
    {"lojista": 310, "loja": 134},
    {"lojista": 17, "loja": 137},
    {"lojista": 53, "loja": 140},
    {"lojista": 99, "loja": 140},
    {"lojista": 49, "loja": 141},
    {"lojista": 149, "loja": 141},
    {"lojista": 38, "loja": 144},
    {"lojista": 3, "loja": 148},
    {"lojista": 299, "loja": 148},
    {"lojista": 301, "loja": 148},
    {"lojista": 85, "loja": 149},
    {"lojista": 110, "loja": 153},
    {"lojista": 67, "loja": 154},
    {"lojista": 68, "loja": 154},
    {"lojista": 329, "loja": 154},
    {"lojista": 11, "loja": 155},
    {"lojista": 53, "loja": 155},
    {"lojista": 99, "loja": 155},
    {"lojista": 179, "loja": 155},
    {"lojista": 223, "loja": 155},
    {"lojista": 48, "loja": 161},
    {"lojista": 20, "loja": 168},
    {"lojista": 65, "loja": 168},
    {"lojista": 80, "loja": 168},
    {"lojista": 83, "loja": 168},
    {"lojista": 107, "loja": 169},
    {"lojista": 297, "loja": 169},
    {"lojista": 298, "loja": 169},
    {"lojista": 4, "loja": 170},
    {"lojista": 136, "loja": 177},
    {"lojista": 159, "loja": 177},
    {"lojista": 12, "loja": 182},
    {"lojista": 39, "loja": 182},
    {"lojista": 100, "loja": 186},
    {"lojista": 104, "loja": 186},
    {"lojista": 86, "loja": 187},
    {"lojista": 222, "loja": 187},
    {"lojista": 106, "loja": 190},
    {"lojista": 108, "loja": 190},
    {"lojista": 109, "loja": 190},
    {"lojista": 330, "loja": 190},
    {"lojista": 47, "loja": 192},
    {"lojista": 89, "loja": 195},
    {"lojista": 90, "loja": 195},
    {"lojista": 9, "loja": 196},
    {"lojista": 61, "loja": 305},
    {"lojista": 62, "loja": 305},
    {"lojista": 37, "loja": 306},
    {"lojista": 150, "loja": 306},
    {"lojista": 28, "loja": 318},
    {"lojista": 29, "loja": 318},
    {"lojista": 98, "loja": 318},
    {"lojista": 219, "loja": 318},
    {"lojista": 8, "loja": 203},
    {"lojista": 1, "loja": 300},
    {"lojista": 137, "loja": 300},
    {"lojista": 138, "loja": 300},
    {"lojista": 160, "loja": 300},
    {"lojista": 173, "loja": 300},
    {"lojista": 177, "loja": 300},
    {"lojista": 178, "loja": 300},
    {"lojista": 180, "loja": 300},
    {"lojista": 239, "loja": 300},
    {"lojista": 241, "loja": 300},
    {"lojista": 254, "loja": 300},
    {"lojista": 265, "loja": 300},
    {"lojista": 280, "loja": 300},
    {"lojista": 288, "loja": 300},
    {"lojista": 337, "loja": 300},
    {"lojista": 18, "loja": 205},
    {"lojista": 76, "loja": 205},
    {"lojista": 276, "loja": 205},
    {"lojista": 309, "loja": 205},
    {"lojista": 134, "loja": 208},
    {"lojista": 164, "loja": 212},
    {"lojista": 212, "loja": 179},
    {"lojista": 76, "loja": 232},
    {"lojista": 77, "loja": 232},
    {"lojista": 76, "loja": 233},
    {"lojista": 82, "loja": 233},
    {"lojista": 93, "loja": 241},
    {"lojista": 139, "loja": 241},
    {"lojista": 250, "loja": 243},
    {"lojista": 85, "loja": 244},
    {"lojista": 12, "loja": 246},
    {"lojista": 66, "loja": 247},
    {"lojista": 119, "loja": 251},
    {"lojista": 120, "loja": 251},
    {"lojista": 121, "loja": 251},
    {"lojista": 220, "loja": 251},
    {"lojista": 316, "loja": 251},
    {"lojista": 119, "loja": 252},
    {"lojista": 255, "loja": 252},
    {"lojista": 316, "loja": 252},
    {"lojista": 317, "loja": 252},
    {"lojista": 118, "loja": 250},
    {"lojista": 119, "loja": 250},
    {"lojista": 121, "loja": 250},
    {"lojista": 316, "loja": 250},
    {"lojista": 334, "loja": 250},
    {"lojista": 100, "loja": 255},
    {"lojista": 6, "loja": 258},
    {"lojista": 6, "loja": 260},
    {"lojista": 290, "loja": 267},
    {"lojista": 100, "loja": 268},
    {"lojista": 295, "loja": 271},
    {"lojista": 188, "loja": 272},
    {"lojista": 307, "loja": 272},
    {"lojista": 93, "loja": 273},
    {"lojista": 139, "loja": 273},
    {"lojista": 313, "loja": 274},
    {"lojista": 100, "loja": 275},
    {"lojista": 249, "loja": 277},
    {"lojista": 157, "loja": 278},
    {"lojista": 296, "loja": 278},
    {"lojista": 336, "loja": 278},
    {"lojista": 157, "loja": 279},
    {"lojista": 266, "loja": 279},
    {"lojista": 296, "loja": 279},
    {"lojista": 93, "loja": 280},
    {"lojista": 93, "loja": 281},
    {"lojista": 93, "loja": 282},
    {"lojista": 93, "loja": 283},
    {"lojista": 39, "loja": 284},
    {"lojista": 70, "loja": 284},
    {"lojista": 71, "loja": 284},
    {"lojista": 39, "loja": 286},
    {"lojista": 70, "loja": 286},
    {"lojista": 71, "loja": 286},
    {"lojista": 39, "loja": 285},
    {"lojista": 70, "loja": 285},
    {"lojista": 71, "loja": 285},
    {"lojista": 119, "loja": 287},
    {"lojista": 93, "loja": 288},
    {"lojista": 133, "loja": 290},
    {"lojista": 13, "loja": 291},
    {"lojista": 285, "loja": 291},
    {"lojista": 93, "loja": 292},
    {"lojista": 119, "loja": 293},
    {"lojista": 2, "loja": 294},
    {"lojista": 122, "loja": 294},
    {"lojista": 287, "loja": 294},
    {"lojista": 2, "loja": 295},
    {"lojista": 122, "loja": 295},
    {"lojista": 287, "loja": 295},
    {"lojista": 119, "loja": 296},
    {"lojista": 100, "loja": 297},
  ];
}
