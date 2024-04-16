import 'package:auto_route/annotations.dart';
import 'package:profair/src/controllers/clients_controller.dart';
import 'package:profair/src/repositories/clients_repository.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/generated/l10n.dart';
import 'package:profair/src/views/clients/components/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class Clients extends StatefulWidget {
  const Clients({super.key, required this.codeProvider, this.accessTargenting, this.merchandise, this.trading});

  final int? codeProvider;
  final int? accessTargenting;
  final int? merchandise;
  final int? trading;

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  final ClientsController clientsController = ClientsController(StateApp.start, ClientsRepository());

  @override
  void initState() {
    clientsController.findClients(
      codeProvider: widget.codeProvider.toString(),
      accessTargenting: widget.accessTargenting,
      trading: widget.trading,
      merchandise: widget.merchandise,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: colorSecondary),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: clientsController.stateClients,
              builder: (context, value, child) {
                return ComponentList(
                    description: S.of(context).text_select_branch,
                    state: clientsController.stateClients,
                    codeProvider: widget.codeProvider,
                    listItems: clientsController.clientsList,
                    clientsController: clientsController,
                    accessTargenting: widget.accessTargenting!);
              },
            ),
          ),
        ),
      ),
    );
  }
}
