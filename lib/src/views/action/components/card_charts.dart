import 'dart:developer';

import 'package:flutter_svg/svg.dart';
import 'package:profair/src/components/line_chart_active.dart';
import 'package:profair/src/components/loading_chart.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/models/active_model.dart';
import 'package:profair/src/repositories/information_model.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/format_currency.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/action/action_controller.dart';
import 'package:profair/src/views/home/components/item_balance.dart';

class CardCharts extends StatefulWidget {
  CardCharts({super.key, required this.action, required this.actionController});

  ActiveModel action;
  ActionController actionController;

  @override
  State<CardCharts> createState() => _CardChartsState();
}

class _CardChartsState extends State<CardCharts> {
  List<InformationModel> informations = [
    InformationModel(total: "R0,00", title: "Ação", color: Colors.orange, icon: Icons.monetization_on_rounded, addInfo: ""),
    InformationModel(total: "0,00", title: "Valor Investido", color: Colors.purple, icon: Icons.monetization_on_rounded, addInfo: ""),
    InformationModel(total: "--", title: "Valor atual", color: Colors.blue, icon: Icons.abc, addInfo: ""),
    InformationModel(total: "--%", title: "Valorização", color: Colors.green, icon: Icons.percent, addInfo: ""),
  ];

  double maxValue = 20000;
  double horizontalInterval = 5000;

  @override
  void initState() {
    inspect(widget.action);
    widget.actionController.findHistoric(widget.action.symbol);
    informations[0].total = widget.action.symbol;
    informations[0].addInfo = formatCurrency(widget.action.valorAtivo!);

    informations[1].total = formatCurrency(widget.action.investimento!);

    informations[2].total = formatCurrency(widget.action.renda!);
    informations[3].total = "${widget.action.valorizacao!}%";
    if (widget.action.valorizacao! < 0) {
      informations[3].color = Colors.red;
    }

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppSpacing(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    padding: const EdgeInsets.all(appPadding),
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Color(0xFF3C7F7B)),
                    child: SvgPicture.network(widget.action.image!),
                  ),
                  Text(
                    "${widget.action.longName}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const AppSpacing(),
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
                "Rendimento",
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
                        valueListenable: widget.actionController.stateHistoric,
                        builder: (context, value, child) {
                          return value == StateApp.loading
                              ? LoadingChart()
                              : LineChartActiveSample2(
                                  maxValue: widget.actionController.maxValue,
                                  historic: widget.actionController.historic!,
                                );
                        }),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
    ;
  }
}
