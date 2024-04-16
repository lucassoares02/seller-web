import 'package:flutter/material.dart';
import 'package:profair/src/components/button.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/controllers/download_controller.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';

class ItemDownload extends StatefulWidget {
  const ItemDownload({super.key, required this.downloadController});

  final DownloadController downloadController;

  @override
  State<ItemDownload> createState() => _ItemDownloadState();
}

class _ItemDownloadState extends State<ItemDownload> {
  exportData() async {
    await widget.downloadController.exportData();
  }

  String csvData = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(appPadding * 3),
          decoration: const BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(appRadius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Exportação dos pedidos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const AppSpacing(),
              const AppSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                      valueListenable: widget.downloadController.stateExport,
                      builder: (context, value, child) {
                        return AppButton(
                          onPressButton: () => exportData(),
                          colorButton: colorSecondary,
                          iconButton: Icons.download,
                          type: "filled",
                          loading: value == StateApp.loading,
                          label: "Exportar",
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
