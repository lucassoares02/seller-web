import 'package:auto_route/auto_route.dart';
import 'package:profair/src/router/router.gr.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/request_client/request_client_controller.dart';

class NegotiationList extends StatefulWidget {
  const NegotiationList({
    super.key,
    required this.requestClientController,
  });

  final RequestClientController requestClientController;

  @override
  State<NegotiationList> createState() => _NegotiationListState();
}

class _NegotiationListState extends State<NegotiationList> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Row(
              children: widget.requestClientController.negotiations.asMap().entries.map((e) {
            return
                // Flexible(
                //   flex: 1,
                //   child:
                InkWell(
              onTap: () {
                AutoRouter.of(context).push(Providers(codeClient: 0, codeBranch: 0, codeBuyer: e.value.negotiation));
              },
              child: Container(
                height: 150,
                width: 350,
                padding: const EdgeInsets.all(appPadding),
                margin: EdgeInsets.only(left: appMargin, right: e.key == widget.requestClientController.negotiations.length - 1 ? appMargin : 0),
                decoration: const BoxDecoration(color: colorSecondary, borderRadius: BorderRadius.all(Radius.circular(appRadius))),
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
                          // '${widget.requestClientController.buyers[index].nameBuyer}',
                          e.value.negotiation.toString(),
                          style: const TextStyle(
                            color: colorWhite,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          e.value.title!,
                          style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: colorWhite,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
