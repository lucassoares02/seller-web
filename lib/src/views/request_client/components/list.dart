import 'package:profair/src/components/header_list.dart';
import 'package:profair/src/components/loading_list.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/views/home/state_management.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/request_client/components/negotation_list.dart';
import 'package:profair/src/views/request_client/components/table_products.dart';
import 'package:profair/src/views/request_client/request_client_controller.dart';

class ComponentList extends StatefulWidget {
  ComponentList({
    super.key,
    this.description,
    required this.state,
    required this.requestClientController,
    required this.codeProvider,
    required this.codeBranch,
    required this.nameBranch,
  });

  final String? description;
  final ValueListenable state;
  final RequestClientController requestClientController;
  final int codeProvider;
  final int codeBranch;
  final String nameBranch;

  @override
  State<ComponentList> createState() => _ComponentListState();
}

class _ComponentListState extends State<ComponentList> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return StateManagement(
      width: width,
      listenable: widget.state,
      widgetLoading: LoadingList(icon: Icons.swap_horiz_rounded, label: "Detalhes do pedido"),
      component: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderList(
            icon: Icons.swap_horiz_rounded,
            activeSearch: false,
            label: "Detalhes do pedido",
          ),
          const AppSpacing(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding),
            child: ValueListenableBuilder(
                valueListenable: widget.requestClientController.stateDetailsProvider,
                builder: (context, value, child) {
                  return value == StateApp.loading
                      ? LoadingList(loadingHeader: false)
                      : Container(
                          decoration: const BoxDecoration(
                              color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(appRadius))),
                          padding: const EdgeInsets.all(appPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Detalhes",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const AppSpacing(),
                              Text(
                                "${widget.codeBranch} - ${widget.nameBranch}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const AppSpacing(),
                              Text(
                                "${widget.requestClientController.detailsProvider!.codeProvider} - ${widget.requestClientController.detailsProvider!.nameProvider}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                }),
          ),
          const AppSpacing(),
          const AppSpacing(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: appPadding),
            child: Text(
              "Negociações",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const AppSpacing(),
          NegotiationList(
              negotiationController: widget.requestClientController,
              action: (value) {
                widget.requestClientController.findMerchandise(widget.codeBranch, widget.codeProvider, value);
              }),
          const AppSpacing(),
          const AppSpacing(),
          const AppSpacing(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: appPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mercadoriass",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    widget.requestClientController.sort();
                  },
                  icon: const Icon(Icons.swap_vert),
                  label: const Text("Reordenar"),
                )
              ],
            ),
          ),
          const AppSpacing(),
          ValueListenableBuilder(
              valueListenable: widget.requestClientController.stateMerchandise,
              builder: (context, value, child) {
                return value == StateApp.loading
                    ? LoadingList(loadingHeader: false)
                    : TableProducts(
                        negotiationController: widget.requestClientController,
                      );
              })
        ],
      ),
    );
  }
}
