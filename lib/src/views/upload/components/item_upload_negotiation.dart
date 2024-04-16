import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:profair/src/components/button.dart';
import 'package:profair/src/components/loading_list.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/components/table_negotiation.dart';
import 'package:profair/src/controllers/upload_controller.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';

class ItemUploadNegotiation extends StatefulWidget {
  const ItemUploadNegotiation({super.key, required this.uploadController});

  final UploadController uploadController;

  @override
  State<ItemUploadNegotiation> createState() => _ItemUploadNegotiationState();
}

class _ItemUploadNegotiationState extends State<ItemUploadNegotiation> {
  saveForm() async {
    if (widget.uploadController.negotiationUpload != null) {
      await widget.uploadController.sendUploadNegotiation();
    }
  }

  String csvData = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          // padding: const EdgeInsets.all(appPadding * 3),
          decoration: const BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(appRadius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: appPadding * 3,
                  right: appPadding * 3,
                  top: appPadding * 3,
                ),
                child: Text(
                  "Importação de Negociações",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const AppSpacing(),
              const AppSpacing(),
              if (widget.uploadController.negotiationUpload!.isNotEmpty)
                ValueListenableBuilder(
                    valueListenable: widget.uploadController.stateUpload,
                    builder: (context, value, child) {
                      return value == StateApp.loading
                          ? LoadingList()
                          : ValueListenableBuilder(
                              valueListenable: widget.uploadController.stateSendData,
                              builder: (context, value, child) {
                                return TableNegotiation(
                                  uploadController: widget.uploadController,
                                );
                              });
                    }),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: ValueListenableBuilder(
                    valueListenable: widget.uploadController.stateSendData,
                    builder: (context, value, child) {
                      return widget.uploadController.negotiationUploadBackup!.isEmpty
                          ? Container()
                          : LinearPercentIndicator(
                              // animation: true,
                              trailing: Text(
                                "${(100 - (widget.uploadController.negotiationUpload!.length / widget.uploadController.negotiationUploadBackup!.length) * 100).toStringAsFixed(0)}%",
                                style: const TextStyle(color: colorBlack, fontSize: 12),
                              ),
                              animationDuration: 500,
                              padding: const EdgeInsets.only(right: 10),
                              lineHeight: 15,
                              barRadius: const Radius.circular(10),
                              percent:
                                  (double.parse("${1 - (widget.uploadController.negotiationUpload!.length / widget.uploadController.negotiationUploadBackup!.length)}")),
                              backgroundColor: colorSecondary.withOpacity(0.2),
                              progressColor: colorSecondary,
                            );
                    }),
              ),
              ValueListenableBuilder(
                  valueListenable: widget.uploadController.finishUploadNegotiation,
                  builder: (context, value, child) {
                    return value == true
                        ? Container(
                            padding: const EdgeInsetsDirectional.all(appPadding * 3),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.check_circle_sharp,
                                  color: colorGreen,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Dados salvo com sucesso!",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(appPadding * 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButton(
                                  onPressButton: () async {
                                    if (widget.uploadController.negotiationUpload!.isNotEmpty) {
                                      widget.uploadController.stateUpload.value = StateApp.loading;
                                      widget.uploadController.negotiationUpload = [];
                                      widget.uploadController.stateUpload.value = StateApp.success;
                                    } else {
                                      await widget.uploadController.uploadCSV("negotiation");
                                    }
                                  },
                                  type: "filled",
                                  colorButton: widget.uploadController.negotiationUpload!.isNotEmpty ? colorGrey : colorSecondary,
                                  iconButton: widget.uploadController.negotiationUpload!.isNotEmpty ? Icons.remove : Icons.upload,
                                  label: widget.uploadController.negotiationUpload!.isNotEmpty ? "Limpar" : "Faça upload",
                                ),
                                if (widget.uploadController.negotiationUpload!.isNotEmpty) const AppSpacing(),
                                if (widget.uploadController.negotiationUpload!.isNotEmpty)
                                  ValueListenableBuilder(
                                    valueListenable: widget.uploadController.stateSendindUploadNegotiaton,
                                    builder: (context, value, child) {
                                      return AppButton(
                                        onPressButton: () => saveForm(),
                                        colorButton: colorSecondary,
                                        iconButton: Icons.check,
                                        loading: value == StateApp.loading,
                                        label: "Salvar",
                                      );
                                    },
                                  ),
                              ],
                            ),
                          );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
