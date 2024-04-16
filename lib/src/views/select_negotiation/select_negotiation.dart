import 'package:auto_route/auto_route.dart';
import 'package:profair/generated/l10n.dart';
import 'package:profair/src/controllers/negotiation_controller.dart';
import 'package:profair/src/repositories/negotiation_repository.dart';
import 'package:profair/src/views/select_negotiation/components/list.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SelectNegotiation extends StatefulWidget {
  const SelectNegotiation({super.key, required this.codeProvider, required this.codeBranch, this.nameBranch, required this.codeClient});

  final int? codeProvider;
  final int? codeBranch;
  final String? nameBranch;
  final int? codeClient;

  @override
  State<SelectNegotiation> createState() => _SelectNegotiationState();
}

class _SelectNegotiationState extends State<SelectNegotiation> {
  final NegotiationController negotiationController = NegotiationController(StateApp.start, NegotiationRepository());

  @override
  void initState() {
    negotiationController.findNegotiations(widget.codeBranch, widget.codeProvider);
    negotiationController.findMerchandise(widget.codeProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: negotiationController.stateNegotiations,
            builder: (context, value, child) {
              return ComponentList(
                listItems: negotiationController.negotiations,
                state: negotiationController.stateNegotiations,
                description: S.of(context).text_select_branch,
                codeBranch: widget.codeBranch,
                codeProvider: widget.codeProvider,
                codeClient: widget.codeClient,
                nameBranch: widget.nameBranch,
                negotiationController: negotiationController,
              );
            },
          ),
        ),
      ),
    );
  }
}
