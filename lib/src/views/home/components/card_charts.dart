import 'package:profair/src/components/loading_chart.dart';
import 'package:profair/src/components/loading_dash.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/shared/responsive.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/home/components/charts/line_chart.dart';
import 'package:profair/src/views/home/components/charts/pie_chart.dart';
import 'package:profair/src/views/home/components/item_balance.dart';
import 'package:profair/src/views/home/home_controller.dart';

class CardCharts extends StatefulWidget {
  CardCharts({super.key, required this.homeController});

  HomeController homeController;

  @override
  State<CardCharts> createState() => _CardChartsState();
}

class _CardChartsState extends State<CardCharts> {
  double maxValue = 20000;
  double horizontalInterval = 5000;
  getMaxValue() {
    for (int i = 0; i < widget.homeController.listValueMinute.length; i++) {
      if (widget.homeController.listValueMinute[i].value! > maxValue) {
        maxValue = widget.homeController.listValueMinute[i].value! + widget.homeController.listValueMinute[i].value! * 0.2;
      }
    }
    horizontalInterval = maxValue / 5;
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
              valueListenable: widget.homeController.stateInformationTeste,
              builder: (context, value, child) {
                return value == StateApp.loading
                    ? LoadingDash()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: widget.homeController.information.asMap().entries.map((e) {
                          return ItemBalance(
                            title: e.value.title!,
                            value: e.value.total!,
                            iconTip: e.value.icon!,
                            valueTip: e.value.addInfo!,
                            color: e.value.color!,
                            index: e.key,
                            homeController: widget.homeController,
                          );
                        }).toList());
              }),
          const AppSpacing(),
          Responsive.isDesktop(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ValueListenableBuilder(
                          valueListenable: widget.homeController.stateChartClients,
                          builder: (context, value, child) {
                            return value == StateApp.loading
                                ? LoadingChart()
                                : widget.homeController.chartClient.first.value != 0
                                    ? Container(
                                        height: 400,
                                        padding: const EdgeInsets.all(appPadding * 2),
                                        decoration:
                                            BoxDecoration(color: colorGreyLigth.withOpacity(0.3), borderRadius: const BorderRadius.all(Radius.circular(appRadius))),
                                        child: PieChartSample2(
                                          homeController: widget.homeController,
                                        ),
                                      )
                                    : Container();
                          }),
                    ),
                    const AppSpacing(),
                    Expanded(
                      child: ValueListenableBuilder(
                          valueListenable: widget.homeController.stateChartPorMinute,
                          builder: (context, value, child) {
                            getMaxValue();
                            return value == StateApp.loading
                                ? LoadingChart()
                                : widget.homeController.listValueMinute.isNotEmpty
                                    ? Container(
                                        width: double.maxFinite,
                                        height: 400,
                                        padding: const EdgeInsets.all(5),
                                        decoration:
                                            BoxDecoration(color: colorGreyLigth.withOpacity(0.3), borderRadius: const BorderRadius.all(Radius.circular(appRadius))),
                                        child: LineChartSample2(
                                          homeController: widget.homeController,
                                          maxValue: maxValue,
                                          horizontalInterval: horizontalInterval,
                                        ),
                                      )
                                    : Container();
                          }),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      child: ValueListenableBuilder(
                          valueListenable: widget.homeController.stateChartClients,
                          builder: (context, value, child) {
                            return value == StateApp.loading
                                ? LoadingChart()
                                : widget.homeController.chartClient.first.value != 0
                                    ? Container(
                                        height: 400,
                                        padding: const EdgeInsets.all(appPadding * 2),
                                        decoration:
                                            BoxDecoration(color: colorGreyLigth.withOpacity(0.3), borderRadius: const BorderRadius.all(Radius.circular(appRadius))),
                                        child: PieChartSample2(
                                          homeController: widget.homeController,
                                        ),
                                      )
                                    : Container();
                          }),
                    ),
                    const AppSpacing(),
                    Container(
                      width: double.maxFinite,
                      child: ValueListenableBuilder(
                          valueListenable: widget.homeController.stateChartPorMinute,
                          builder: (context, value, child) {
                            getMaxValue();
                            return value == StateApp.loading
                                ? LoadingChart()
                                : widget.homeController.listValueMinute.isNotEmpty
                                    ? Container(
                                        width: double.maxFinite,
                                        height: 400,
                                        padding: const EdgeInsets.all(5),
                                        decoration:
                                            BoxDecoration(color: colorGreyLigth.withOpacity(0.3), borderRadius: const BorderRadius.all(Radius.circular(appRadius))),
                                        child: LineChartSample2(
                                          homeController: widget.homeController,
                                          maxValue: maxValue,
                                          horizontalInterval: horizontalInterval,
                                        ),
                                      )
                                    : Container();
                          }),
                    ),
                  ],
                )
        ],
      ),
    );
    ;
  }
}
