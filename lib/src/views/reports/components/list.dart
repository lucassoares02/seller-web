import 'package:profair/src/components/loading_list.dart';
import 'package:profair/src/views/reports/components/card_percentage.dart';
import 'package:profair/src/views/reports/components/chart_negotiation.dart';
import 'package:profair/src/views/reports/components/chart_product.dart';
import 'package:profair/src/controllers/reports_controller.dart';
import 'package:profair/src/components/header_list.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ComponentList extends StatefulWidget {
  ComponentList({super.key, required this.reportsController, this.codeProvider, this.accessTargeting});

  int? codeProvider;
  int? accessTargeting;

  final ReportsController reportsController;

  @override
  State<ComponentList> createState() => _ComponentListState();
}

class _ComponentListState extends State<ComponentList> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderList(
          icon: Icons.show_chart_rounded,
          activeSearch: false,
          label: "Relatórios",
        ),
        Container(
          padding: const EdgeInsets.all(appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ValueListenableBuilder(
                      valueListenable: widget.reportsController.statePercentageClients,
                      builder: (context, value, child) {
                        return value == StateApp.loading
                            ? LoadingList(loadingHeader: false)
                            : CardPercentage(
                                listanable: widget.reportsController.statePercentageClients,
                                title: widget.accessTargeting == 1 || widget.accessTargeting == 3 ? "Clientes Atendidos" : "Fornecedores visitados",
                                content:
                                    "Nessa sessão é possível visualizar quantos ${widget.accessTargeting == 1 || widget.accessTargeting == 3 ? "associados" : "fornecedores"} foram atendidos até o momento em relação a quantidade total presentes na feira",
                                value: "${double.parse("${widget.reportsController.percentageClients!.percentage}").toStringAsFixed(0)}%",
                                footer: "${widget.reportsController.percentageClients!.parcial} de ${widget.reportsController.percentageClients!.total} foram atendidos",
                                reportsController: widget.reportsController,
                              );
                      },
                    ),
                  ),
                  const AppSpacing(),
                  if (widget.accessTargeting == 3 || widget.accessTargeting == 1)
                    Flexible(
                      flex: 1,
                      child: ValueListenableBuilder(
                          valueListenable: widget.reportsController.statePercentageProviders,
                          builder: (context, value, child) {
                            return value == StateApp.loading
                                ? LoadingList(loadingHeader: false)
                                : CardPercentage(
                                    listanable: widget.reportsController.statePercentageProviders,
                                    backgroundColor: colorRed,
                                    reportsController: widget.reportsController,
                                    content: "\n",
                                    title: "Fornecedores com venda",
                                    value: "${double.parse("${widget.reportsController.percentageProviders!.percentage}").toStringAsFixed(0)}%",
                                    footer:
                                        "${widget.reportsController.percentageProviders!.parcial} de ${widget.reportsController.percentageProviders!.total} realizaram vendas.",
                                  );
                          }),
                    ),
                ],
              ),
              const AppSpacing(),
              const AppSpacing(),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.accessTargeting == 1
                                ? "Ranking de Associados"
                                : widget.accessTargeting == 2
                                    ? "Ranking de Fornecedores"
                                    : "Ranking de Clientes",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const AppSpacing(),
                          ValueListenableBuilder(
                            valueListenable: widget.reportsController.stateReports,
                            builder: (context, value, child) {
                              return value == StateApp.loading
                                  ? SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                        height: 500,
                                        width: width,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.only(top: appPadding * 5, right: appPadding, left: appPadding, bottom: appPadding),
                                      height: 500,
                                      decoration: const BoxDecoration(
                                        color: colorGreyLigth,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(appRadius),
                                        ),
                                      ),
                                      child: BarChartTeste(reportsClients: widget.reportsController.reportsTotalClient));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const AppSpacing(),
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.accessTargeting == 3 || widget.accessTargeting == 1)
                            Text(
                              widget.codeProvider == 0 ? "Ranking Fornecedores" : "Ranking de produtos",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const AppSpacing(),
                          if (widget.accessTargeting == 3 || widget.accessTargeting == 1)
                            (widget.codeProvider == 0)
                                ? ValueListenableBuilder(
                                    valueListenable: widget.reportsController.stateReports,
                                    builder: (context, value, child) {
                                      return value == StateApp.loading
                                          ? SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                height: 500,
                                                width: width,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            )
                                          : Container(
                                              padding: const EdgeInsets.only(top: appPadding * 5, right: appPadding, bottom: appPadding),
                                              height: 500,
                                              decoration: const BoxDecoration(
                                                color: colorGreyLigth,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(appRadius),
                                                ),
                                              ),
                                              child: BarChartTeste(reportsClients: widget.reportsController.reportsTotalProvider));
                                    },
                                  )
                                : ValueListenableBuilder(
                                    valueListenable: widget.reportsController.stateReportsProducts,
                                    builder: (context, value, child) {
                                      return value == StateApp.loading
                                          ? SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                height: 500,
                                                width: width,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            )
                                          // : BarChartTeste(listItems: widget.reportsController.reportsTotalProducts);
                                          : Container(
                                              // padding: const EdgeInsets.only(top: appPadding * 3, right: appPadding * 2, left: appPadding * 2, bottom: appPadding),
                                              height: 500,
                                              padding: const EdgeInsets.only(top: appPadding * 3),
                                              decoration: const BoxDecoration(
                                                color: colorGreyLigth,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(appRadius),
                                                ),
                                              ),
                                              child: BarChartSample1(reportsProducts: widget.reportsController.reportsTotalProducts));
                                    }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
