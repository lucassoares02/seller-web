import 'package:profair/src/components/header_list.dart';
import 'package:profair/src/components/loading_list.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/controllers/negotiation_controller.dart';
import 'package:profair/src/models/nogotiation_model.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/views/home/state_management.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/select_negotiation/components/negotation_list.dart';
import 'package:profair/src/views/select_negotiation/components/table_products.dart';

class ComponentList extends StatefulWidget {
  ComponentList({
    super.key,
    required this.listItems,
    this.description,
    this.codeBranch,
    this.codeProvider,
    this.codeClient,
    this.nameBranch,
    required this.state,
    required this.negotiationController,
  });

  List<NegotiationModel> listItems;
  final String? description;
  final ValueListenable state;
  final int? codeBranch;
  final String? nameBranch;
  final int? codeProvider;
  final int? codeClient;
  final NegotiationController negotiationController;

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
      widgetLoading: LoadingList(icon: Icons.swap_horiz_rounded, label: "Detalhes do Fornecedor"),
      component: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderList(
            icon: Icons.swap_horiz_rounded,
            activeSearch: false,
            label: "Detalhes do Fornecedor",
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
          NegotiationList(negotiationController: widget.negotiationController),
          const AppSpacing(),
          const AppSpacing(),
          const AppSpacing(),
          const AppSpacing(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: appPadding),
            child: Text(
              "Mercadorias",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: widget.negotiationController.stateMerchandise,
              builder: (context, value, child) {
                return value == StateApp.loading ? LoadingList(loadingHeader: false) : TableProducts(negotiationController: widget.negotiationController);
              })
          // Column(
          //     children: widget.negotiationController.products.asMap().entries.map((e) {
          //   return InkWell(
          //     // onTap: () {
          //     //   widget.listItems[e.key].checked = true;
          //     //   Navigator.of(context).pushNamed('tradingproducts', arguments: {
          //     //     "codeProvider": widget.codeProvider,
          //     //     "codeBranch": widget.codeBranch,
          //     //     "nameBranch": widget.nameBranch,
          //     //     "codeClient": widget.codeClient,
          //     //     "codeTrading": e.value.negotiation,
          //     //     "tradings": widget.listItems,
          //     //   });
          //     // },
          //     child: Container(
          //       height: 120,
          //       padding: const EdgeInsets.all(appMargin),
          //       margin: const EdgeInsets.symmetric(horizontal: appMargin),
          //       decoration: const BoxDecoration(
          //         border: Border(bottom: BorderSide(color: colorGrey)),
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             "${e.value.codeProduct} - ${e.value.title}",
          //             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 '${e.value.price} - ${e.value.total}',
          //                 style: const TextStyle(color: colorGreyDark),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
          // }).toList())
        ],
      ),
    );
  }
}
