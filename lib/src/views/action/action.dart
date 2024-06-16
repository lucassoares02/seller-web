import 'package:auto_route/auto_route.dart';
import 'package:profair/src/components/side_menu.dart';
import 'package:profair/src/models/active_model.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/views/action/action_controller.dart';
import 'package:profair/src/views/action/action_repository.dart';
import 'package:profair/src/views/action/components/card_charts.dart';
import 'package:profair/src/views/home/components/card_welcome.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ActionPage extends StatefulWidget {
  const ActionPage({super.key, this.action});

  final ActiveModel? action;

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  ActionController actionController = ActionController(StateApp.start, ActionRepository());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.action == null) {
      AutoRouter.of(context).pushNamed("/");
    }
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenu(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppSpacing(),
                    const AppSpacing(),
                    const AppSpacing(),
                    CardWelcome(),
                    if (widget.action != null)
                      CardCharts(
                        action: widget.action!,
                        actionController: actionController,
                      ),
                    const AppSpacing(),
                    const AppSpacing(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
