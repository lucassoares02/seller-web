import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:profair/src/components/loading_dash.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/controllers/download_controller.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/format_currency.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/views/home/home_controller.dart';

class ItemDownloadClient extends StatefulWidget {
  const ItemDownloadClient({super.key, required this.downloadController, required this.homeController});

  final DownloadController downloadController;
  final HomeController homeController;

  @override
  State<ItemDownloadClient> createState() => _ItemDownloadClientState();
}

class _ItemDownloadClientState extends State<ItemDownloadClient> {
  TextEditingController controllerSearch = TextEditingController();
  bool stateSearch = false;

  exportData(int codeClient) async {
    await widget.downloadController.exportDataClient(codeClient);
  }

  exportDataProvider(int codeClient, int codeProvider) async {
    await widget.downloadController.exportDataClientProvider(codeClient, codeProvider);
  }

  String csvData = '';

  @override
  void initState() {
    getListProvider();
    super.initState();
  }

  getListProvider() async {
    for (var element in widget.homeController.moreData!) {
      await widget.downloadController.listProviders(element.codCompany!, element.nameCompany!, element.valueOrder!);
    }
    widget.downloadController.stateListProviders.value = StateApp.success;
  }

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
              // const AppSpacing(),
              // Container(
              //   width: 400,
              //   child: Row(
              //     children: [
              //       DropdownButton<int>(
              //           // decoration: InputDecoration(
              //           //   border: OutlineInputBorder(
              //           //     borderRadius: BorderRadius.circular(20),
              //           //   ),
              //           // ),
              //           value: 0,
              //           items: const [
              //             DropdownMenuItem(value: 0, child: Text("Todos")),
              //             DropdownMenuItem(value: 1, child: Text("Fornecedor")),
              //             DropdownMenuItem(value: 2, child: Text("Negociação")),
              //           ],
              //           onChanged: (value) {})
              //     ],
              //   ),
              // ),

              const AppSpacing(),
              ValueListenableBuilder(
                  valueListenable: widget.downloadController.stateListProviders,
                  builder: (context, value, child) {
                    return value == StateApp.loading
                        ? LoadingDash()
                        : Column(
                            children: widget.downloadController.clientProviders.asMap().entries.map((e) {
                            return ExpansionTile(
                                shape: Border.symmetric(
                                    horizontal: BorderSide(color: Theme.of(context).colorScheme.surfaceVariant)),
                                leading: const Icon(
                                  Icons.downloading_sharp,
                                  color: colorGreen,
                                ),
                                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                title: Container(
                                  // decoration: BoxDecoration(color: Colors.orange),
                                  margin: const EdgeInsets.only(top: appMargin * 2),
                                  child: Text(
                                    e.value.client!,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      "R\$${e.value.value}",
                                    ),
                                    const AppSpacing(),
                                    e.value.value != "0,00"
                                        ? TextButton.icon(
                                            icon: const Icon(
                                              Icons.file_download_rounded,
                                            ),
                                            onPressed: () {
                                              exportData(e.value.code!);
                                            },
                                            label: const Text("Exportar todos os pedidos"))
                                        : const Text(
                                            "Não possuí pedidos",
                                            style: TextStyle(color: colorGrey),
                                          )
                                  ],
                                ),
                                children: [
                                  if (e.value.providers!.isNotEmpty)
                                    stateSearch
                                        ? TextField(
                                            autofocus: true,
                                            cursorColor: colorSecondary,
                                            controller: controllerSearch,
                                            decoration: InputDecoration(
                                              filled: true,
                                              contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      stateSearch = !stateSearch;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.close)),
                                              prefixIcon: const Icon(Icons.search),
                                              hintText: "Pesquisar",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              widget.downloadController.search(value, e.key);
                                            },
                                          )
                                        : TextButton.icon(
                                            onPressed: () {
                                              setState(() {
                                                stateSearch = !stateSearch;
                                              });
                                            },
                                            icon: const Icon(Icons.search),
                                            label: const Text("Pesquisar")),
                                  Column(
                                      children: e.value.providers!.map((provider) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(vertical: appMargin),
                                      padding: const EdgeInsets.all(appPadding),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: colorGrey,
                                          ),
                                          borderRadius: BorderRadius.circular(appRadius)),
                                      child: Row(
                                        children: [
                                          const AppSpacing(),
                                          Text("${provider.codeProvider} - ${provider.nameProvider!}"),
                                          const AppSpacing(),
                                          Text(
                                            formatCurrency(provider.totalValue!),
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const AppSpacing(),
                                          TextButton.icon(
                                              icon: const Icon(
                                                Icons.file_download_rounded,
                                              ),
                                              onPressed: () {
                                                exportDataProvider(e.value.code!, provider.codeProvider!);
                                              },
                                              label: const Text("Exportar"))
                                        ],
                                      ),
                                    );
                                  }).toList())
                                ]);
                            // return Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       "${e.value.codCompany} - ${e.value.nameCompany}",
                            //       style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            //     ),
                            //     const AppSpacing(),
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       children: [
                            //         InkWell(
                            //           onTap: () => exportData(e.value.codCompany!),
                            //           child: MouseRegion(
                            //             cursor: MaterialStateMouseCursor.clickable,
                            //             child: Container(
                            //               padding: const EdgeInsets.symmetric(horizontal: appPadding, vertical: appMargin),
                            //               decoration: BoxDecoration(
                            //                 border: Border.all(color: colorGreen, width: 2),
                            //                 borderRadius: const BorderRadius.all(Radius.circular(appRadius)),
                            //               ),
                            //               child: Row(
                            //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 crossAxisAlignment: CrossAxisAlignment.center,
                            //                 children: [
                            //                   const Icon(Icons.description, color: colorGreen),
                            //                   const SizedBox(width: 10),
                            //                   Text(
                            //                     "${e.value.nameCompany!.toLowerCase().replaceAll(" ", "_")}_exportacao.csv",
                            //                     style: const TextStyle(fontWeight: FontWeight.w500),
                            //                   )
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     const AppSpacing(),
                            //     const AppSpacing(),
                            //   ],
                            // );
                          }).toList());
                  }),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     ValueListenableBuilder(
              //         valueListenable: widget.downloadController.stateExport,
              //         builder: (context, value, child) {
              //           return AppButton(
              //             onPressButton: () {},
              //             colorButton: colorSecondary,
              //             iconButton: Icons.download,
              //             type: "filled",
              //             loading: value == StateApp.loading,
              //             label: "Exportar",
              //           );
              //         }),
              //   ],
              // )
            ],
          ),
        ),
      ],
    );
  }
}
