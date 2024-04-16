import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:profair/src/components/button.dart';
import 'package:profair/src/components/loading_list.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/components/table_merchandise.dart';
import 'package:profair/src/controllers/upload_controller.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';

class ItemUploadMerchandise extends StatefulWidget {
  const ItemUploadMerchandise({super.key, required this.uploadController});

  final UploadController uploadController;

  @override
  State<ItemUploadMerchandise> createState() => _ItemUploadMerchandiseState();
}

class _ItemUploadMerchandiseState extends State<ItemUploadMerchandise> {
  saveForm() async {
    if (widget.uploadController.merchandiseUpload != null) {
      await widget.uploadController.sendUploadMerchandise();
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
                  "Importação de Mercadorias",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const AppSpacing(),
              const AppSpacing(),
              if (widget.uploadController.merchandiseUpload!.isNotEmpty)
                ValueListenableBuilder(
                    valueListenable: widget.uploadController.stateUpload,
                    builder: (context, value, child) {
                      return value == StateApp.loading
                          ? LoadingList()
                          : ValueListenableBuilder(
                              valueListenable: widget.uploadController.stateSendData,
                              builder: (context, value, child) {
                                return TableMerchandise(
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
                      return widget.uploadController.renew.isEmpty
                          ? Container()
                          : LinearPercentIndicator(
                              // animation: true,
                              trailing: Text(
                                "${(100 - (widget.uploadController.merchandiseUpload!.length / widget.uploadController.renew.length) * 100).toStringAsFixed(0)}%",
                                style: const TextStyle(color: colorBlack, fontSize: 12),
                              ),
                              animationDuration: 500,
                              padding: const EdgeInsets.only(right: 10),
                              lineHeight: 15,
                              barRadius: const Radius.circular(10),
                              percent: (double.parse("${1 - (widget.uploadController.merchandiseUpload!.length / widget.uploadController.renew.length)}")),
                              backgroundColor: colorSecondary.withOpacity(0.2),
                              progressColor: colorSecondary,
                            );
                    }),
              ),
              ValueListenableBuilder(
                  valueListenable: widget.uploadController.finishUploadMerchandise,
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
                                    if (widget.uploadController.merchandiseUpload!.isNotEmpty) {
                                      widget.uploadController.stateUpload.value = StateApp.loading;
                                      widget.uploadController.merchandiseUpload = [];
                                      widget.uploadController.stateUpload.value = StateApp.success;
                                    } else {
                                      await widget.uploadController.uploadCSV("merchandise");
                                    }
                                  },
                                  type: "filled",
                                  colorButton: widget.uploadController.merchandiseUpload!.isNotEmpty ? colorGrey : colorSecondary,
                                  iconButton: widget.uploadController.merchandiseUpload!.isNotEmpty ? Icons.remove : Icons.upload,
                                  label: widget.uploadController.merchandiseUpload!.isNotEmpty ? "Limpar" : "Faça upload",
                                ),
                                if (widget.uploadController.merchandiseUpload!.isNotEmpty) const AppSpacing(),
                                if (widget.uploadController.merchandiseUpload!.isNotEmpty)
                                  ValueListenableBuilder(
                                    valueListenable: widget.uploadController.stateSendindUploadMerchandise,
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
