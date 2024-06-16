import 'package:profair/src/components/dropdownbutton.dart';
import 'package:profair/src/components/line_chart.dart';
import 'package:profair/src/components/line_chart_all.dart';
import 'package:profair/src/components/loading_chart.dart';
import 'package:profair/src/components/loading_dash.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/repositories/information_model.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/format_currency.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/home/components/item_balance.dart';
import 'package:profair/src/views/home/home_controller.dart';

class CardCharts extends StatefulWidget {
  CardCharts({super.key, required this.homeController});

  HomeController homeController;

  @override
  State<CardCharts> createState() => _CardChartsState();
}

class _CardChartsState extends State<CardCharts> {
  List<InformationModel> informations = [
    InformationModel(total: "R\$100,00", title: "Valor total", color: Colors.orange, icon: Icons.monetization_on_rounded, addInfo: ""),
    InformationModel(total: "R\$124,00", title: "Valor atual", color: Colors.purple, icon: Icons.monetization_on_rounded, addInfo: ""),
    InformationModel(total: "23%", title: "Valorização", color: Colors.green, icon: Icons.percent, addInfo: ""),
    InformationModel(total: "10", title: "Quantidade de ativos", color: Colors.blue, icon: Icons.abc, addInfo: ""),
  ];

  double maxValue = 20000;
  double horizontalInterval = 5000;

  @override
  void initState() {
    // inspect(widget.homeController.detailsWallet![0]);
    informations[0].total = formatCurrency(widget.homeController.detailsWallet![0].investiment!);
    informations[1].total = formatCurrency(widget.homeController.detailsWallet![0].performance!);
    informations[2].total = "${widget.homeController.detailsWallet![0].appreciation!}%";
    informations[3].total = "${widget.homeController.detailsWallet![0].count!}";
    if (widget.homeController.detailsWallet![0].appreciation! < 0) informations[2].color = Colors.red;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: widget.homeController.stateActives,
            builder: (context, value, child) {
              return value == StateApp.loading
                  ? LoadingDash()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: informations.asMap().entries.map((e) {
                              return ItemBalance(
                                title: e.value.title!,
                                value: e.value.total!,
                                iconTip: e.value.icon!,
                                valueTip: e.value.addInfo!,
                                color: e.value.color!,
                                index: e.key,
                              );
                            }).toList()),
                        const AppSpacing(),
                        const Text(
                          "Ações da carteira",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const AppSpacing(),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(appPadding),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(appRadius),
                                color: Colors.grey.withOpacity(
                                  0.1,
                                ),
                              ),
                              height: 300,
                              width: double.maxFinite,
                              child: ValueListenableBuilder(
                                valueListenable: widget.homeController.stateHistoric,
                                builder: (context, value, child) {
                                  return value == StateApp.loading
                                      ? LoadingChart()
                                      : LineChartSample2(
                                          homeController: widget.homeController,
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                        const AppSpacing(),
                        const Text(
                          "Variação de todos os ativos",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const AppSpacing(),
                        Container(
                          padding: const EdgeInsets.all(appPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(appRadius),
                            color: Colors.grey.withOpacity(
                              0.1,
                            ),
                          ),
                          height: 300,
                          width: double.maxFinite,
                          child: ValueListenableBuilder(
                            valueListenable: widget.homeController.stateHistoricAll,
                            builder: (context, value, child) {
                              return value == StateApp.loading
                                  ? LoadingChart()
                                  : LineChartSample2All(
                                      homeController: widget.homeController,
                                    );
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
    ;
  }
}
