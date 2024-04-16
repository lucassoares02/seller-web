import 'package:auto_route/auto_route.dart';
import 'package:profair/generated/l10n.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/request_client/components/list.dart';
import 'package:profair/src/views/request_client/request_client_controller.dart';
import 'package:profair/src/views/request_client/request_client_repository.dart';

@RoutePage()
class RequestClient extends StatefulWidget {
  const RequestClient({super.key, required this.codeBranch, required this.codeProvider, required this.valueTotal, required this.nameClient});

  final int codeBranch;
  final int codeProvider;
  final double? valueTotal;
  final String? nameClient;

  @override
  State<RequestClient> createState() => _RequestClientState();
}

class _RequestClientState extends State<RequestClient> {
  final RequestClientController requestClientController = RequestClientController(StateApp.start, RequestClientRepository());

  @override
  void initState() {
    requestClientController.findNegotiation(widget.codeBranch, widget.codeProvider, widget.valueTotal!);
    requestClientController.findMerchandise(widget.codeBranch, widget.codeProvider, 0);
    requestClientController.findDetailsProvider(widget.codeProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: requestClientController.stateMerchandise,
            builder: (context, value, child) {
              return ComponentList(
                description: S.of(context).text_select_branch,
                requestClientController: requestClientController,
                state: requestClientController.stateNegotiation,
                codeBranch: widget.codeBranch,
                codeProvider: widget.codeProvider,
                nameBranch: widget.nameClient!,
              );
            },
          ),
        ),
      ),
    );
  }
}
