import 'package:auto_route/auto_route.dart';
import 'package:profair/src/router/router.gr.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/format_currency.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/request_client/request_client_controller.dart';

class NegotiationList extends StatefulWidget {
  const NegotiationList({super.key, required this.negotiationController, required this.action});

  final RequestClientController negotiationController;
  final Function(int)? action;

  @override
  State<NegotiationList> createState() => _NegotiationListState();
}

class _NegotiationListState extends State<NegotiationList> {
  ValueNotifier<int> index = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Row(
              children: widget.negotiationController.negotiations.asMap().entries.map((e) {
            return
                // Flexible(
                //   flex: 1,
                //   child:
                InkWell(
              onTap: () {
                // AutoRouter.of(context).push(Providers(codeClient: 0, codeBranch: 0, codeBuyer: e.value.negotiation));
                widget.action!(e.value.negotiation!);
                index.value = e.key;
              },
              child: ValueListenableBuilder(
                  valueListenable: index,
                  builder: (context, value, child) {
                    return Container(
                      height: 150,
                      width: 350,
                      padding: const EdgeInsets.all(appPadding),
                      margin: EdgeInsets.only(left: appMargin, right: e.key == widget.negotiationController.negotiations.length - 1 ? appMargin : 0),
                      decoration: BoxDecoration(
                        color: value == e.key ? colorSecondary : colorGrey,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(appRadius),
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.handshake_rounded,
                                color: colorWhite.withOpacity(0.7),
                                size: 30,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                // '${widget.negotiationController.buyers[index].nameBuyer}',
                                formatCurrency(e.value.value!),
                                style: const TextStyle(
                                  color: colorWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                " ${e.value.negotiation.toString()} - ${e.value.title!}",
                                style: const TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: colorWhite,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              // ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
