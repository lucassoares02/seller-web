import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/components/loading_dash.dart';
import 'package:profair/src/components/side_menu.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/views/home/components/card_welcome.dart';
import 'package:profair/src/views/operation/operation_controller.dart';
import 'package:profair/src/views/operation/operation_repository.dart';

@RoutePage()
class Operation extends StatefulWidget {
  const Operation({super.key});

  @override
  State<Operation> createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  final OperationController _walletController = OperationController(StateApp.start, OperationRepository());

  @override
  void initState() {
    _walletController.findActives();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    const AppSpacing(),
                    Padding(
                      padding: const EdgeInsets.all(appPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Operações",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const AppSpacing(),
                          ValueListenableBuilder(
                              valueListenable: _walletController.stateActives,
                              builder: (context, value, child) {
                                return value == StateApp.loading
                                    ? LoadingDash()
                                    : Column(
                                        children: _walletController.actives!.asMap().entries.map((e) {
                                          return Container(
                                            height: 90,
                                            padding: const EdgeInsets.all(appPadding),
                                            margin: const EdgeInsets.only(bottom: appPadding),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: Colors.grey.withOpacity(0.4),
                                              ),
                                              borderRadius: BorderRadius.circular(appRadius),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 80,
                                                    padding: const EdgeInsets.all(appPadding),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Color(0xFF3C7F7B)),
                                                    child: Image.network(
                                                      e.value.image!,
                                                      fit: BoxFit.contain,
                                                    )),
                                                const AppSpacing(),
                                                Text("${e.value.longName}"),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      );
                              }),
                        ],
                      ),
                    ),
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
