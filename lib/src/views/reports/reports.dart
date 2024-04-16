import 'package:auto_route/annotations.dart';
import 'package:profair/src/controllers/reports_controller.dart';
import 'package:profair/src/repositories/reports_repository.dart';
import 'package:profair/src/views/home/home_controller.dart';
import 'package:profair/src/views/reports/components/list.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

@RoutePage()
class Reports extends StatefulWidget {
  Reports({super.key, required this.codeProvider, required this.accessTargeting});

  int? codeProvider;
  int? accessTargeting;

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final ReportsController reportsController = ReportsController(StateApp.start, ReportsRepository());
  HomeController? homeController;

  @override
  void initState() {
    homeController = Provider.of<HomeController>(context, listen: false);
    print("Passando por aqui");
    reportsController.findPercentageClients(0, homeController!.data!.accessTargeting);
    reportsController.findTotalValueClients(0, homeController!.data!.accessTargeting);
    reportsController.findTotalValueProducts(0, homeController!.data!.accessTargeting!);
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
              valueListenable: reportsController.statePercentageClients,
              builder: (context, value, child) {
                return ComponentList(
                  reportsController: reportsController,
                  codeProvider: widget.codeProvider,
                  accessTargeting: widget.accessTargeting,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
