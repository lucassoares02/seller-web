import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:profair/provider/appwriter.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';

class SettingsController extends ValueNotifier<StateApp> {
  SettingsController(super.value, this.appWrite);

  final AppWrite appWrite;
  DocumentList? alerts;
  DocumentList? documents;
  int? codeProvider;

  final stateFind = ValueNotifier<StateApp>(StateApp.start);
  final stateSave = ValueNotifier<StateApp>(StateApp.start);
  final stateDelete = ValueNotifier<StateApp>(StateApp.start);
  final stateFindNotice = ValueNotifier<StateApp>(StateApp.start);
  final stateSaveNotice = ValueNotifier<StateApp>(StateApp.start);

  TextEditingController title = TextEditingController();
  TextEditingController priority = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController description = TextEditingController();
  ValueNotifier<String?> idAlert = ValueNotifier(null);
  ValueNotifier<bool> visibleForm = ValueNotifier(false);

  TextEditingController titleNotice = TextEditingController();
  TextEditingController legendNotice = TextEditingController();
  TextEditingController descriptionButtonNotice = TextEditingController();
  TextEditingController descriptionNotice = TextEditingController();
  TextEditingController stampNotice = TextEditingController();
  TextEditingController colorNotice = TextEditingController();
  TextEditingController stampColorNotice = TextEditingController();
  ValueNotifier<bool> updateInput = ValueNotifier(false);

  Future findSettings() async {
    stateFind.value = StateApp.loading;
    try {
      stateFind.value = StateApp.success;
    } catch (e) {
      stateFind.value = StateApp.error;
    }
  }

  Future saveSettings(String title, String time, int priority, String description) async {
    stateSave.value = StateApp.loading;

    try {
      if (idAlert.value != null) {
        await appWrite.updateDocuments(
            documentId: idAlert.value!, collectionId: "64ea1ced75f87c91474e", data: {"title": title, "time": time, "priority": priority, "description": description});
      } else {
        await appWrite.createDocuments(collectionId: "64ea1ced75f87c91474e", data: {"title": title, "time": time, "priority": priority, "description": description});
      }
      stateSave.value = StateApp.success;
      idAlert.value = null;
      findAlert();
    } catch (e) {
      stateSave.value = StateApp.error;
    }
  }

  Future findAlert() async {
    try {
      alerts = await appWrite.getDocuments("64ea1ced75f87c91474e", [Query.orderDesc("priority")]);

      stateFind.value = StateApp.loading;
      stateFind.value = StateApp.success;
    } catch (e) {
      stateFind.value = StateApp.error;
    }
  }

  Future deleteAlert() async {
    try {
      await appWrite.deleteDocuments("64ea1ced75f87c91474e", idAlert.value!);

      stateDelete.value = StateApp.loading;
      stateDelete.value = StateApp.success;
      findAlert();
      idAlert.value = null;
    } catch (e) {
      stateDelete.value = StateApp.error;
    }
  }

  Future findNotice() async {
    stateFindNotice.value = StateApp.loading;
    try {
      documents = await appWrite.getDocuments("64e4fd339e70e9e3f1ca", null);

      titleNotice.text = documents!.documents[0].data["title"] ?? "";
      legendNotice.text = documents!.documents[0].data["content"] ?? "";
      descriptionButtonNotice.text = documents!.documents[0].data["button_description"] ?? "";
      descriptionNotice.text = documents!.documents[0].data["body"] ?? "";
      stampNotice.text = documents!.documents[0].data["stamp"] ?? "";
      colorNotice.text = documents!.documents[0].data["color"] ?? "";
      stampColorNotice.text = documents!.documents[0].data["colorStamp"] ?? "";

      stateFindNotice.value = StateApp.success;
    } catch (e) {
      print("Error Find Documents $e");
      stateFindNotice.value = StateApp.error;
    }
  }

  Future findNoticeRealTime() async {
    try {
      final subscription = await appWrite.listDocumentsRealTime();
      subscription.stream.listen((response) {
        final index = documents!.documents.indexWhere((item) => (item.$id).toString() == response.payload["\$id"].toString());
        if (index != -1) {
          stateFindNotice.value = StateApp.loading;
          documents!.documents[index].data["title"] = response.payload["title"];
          documents!.documents[index].data["content"] = response.payload["content"];
          documents!.documents[index].data["color"] = response.payload["color"];
          stateFindNotice.value = StateApp.success;
        }
      });
    } catch (e) {
      print("Error Init Real Time:f $e");
      stateFindNotice.value = StateApp.error;
    }
  }

  Future saveNotice() async {
    print("======= SAVE NOTICE =======");
    stateSaveNotice.value = StateApp.loading;

    try {
      inspect(documents!.documents[0].data);
      await appWrite.updateDocuments(
        documentId: documents!.documents[0].data["\$id"],
        collectionId: "64e4fd339e70e9e3f1ca",
        data: {
          "title": titleNotice.text,
          "content": legendNotice.text,
          "body": descriptionButtonNotice.text,
          "image": "",
          "payload": 1,
          "color": colorNotice.text,
          "button_description": descriptionButtonNotice.text,
          "stamp": stampNotice.text,
          "colorStamp": stampColorNotice.text,
        },
      );

      stateSaveNotice.value = StateApp.success;
      idAlert.value = null;
      findAlert();
    } catch (e) {
      stateSaveNotice.value = StateApp.error;
    }
  }
}
