import 'package:auto_route/annotations.dart';
import 'package:profair/src/components/dropdownbutton.dart';
import 'package:profair/src/components/loading_dash.dart';
import 'package:profair/src/components/progress_indicator.dart';
import 'package:profair/src/components/side_menu.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/views/home/components/card_charts.dart';
import 'package:profair/src/views/home/components/card_welcome.dart';
import 'package:profair/src/views/home/home_controller.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController? homeController;

  @override
  void initState() {
    homeController = Provider.of<HomeController>(context, listen: false);
    getPreferences();
    super.initState();
  }

  getPreferences() async {
    SharedPreferences sharePref = await SharedPreferences.getInstance();
    String? drop = sharePref.getString("valuedrop");
    homeController!.findActives();
    homeController!.findDetails(drop == "true");
    homeController!.findHistoric(drop == "true");
    homeController!.findHistoricAllActions(drop == "true");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                    Padding(
                      padding: const EdgeInsets.all(appPadding),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppSpacing(),
                              const Text(
                                "Selecione a carteira",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const AppSpacing(),
                              AppDropDownButton(function: (value) {
                                homeController!.findActives();
                                homeController!.findDetails(value == "true");
                                homeController!.findHistoric(value == "true");
                                homeController!.findHistoricAllActions(value == "true");
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const AppSpacing(),
                    ValueListenableBuilder(
                        valueListenable: homeController!.stateDetails,
                        builder: (context, value, child) {
                          return value == StateApp.loading ? LoadingDash() : CardCharts(homeController: homeController!);
                        }),
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
