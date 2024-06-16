import 'package:auto_route/auto_route.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/router/router.gr.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/shared/responsive.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  SideMenu({Key? key, this.action}) : super(key: key);

  Function()? action;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  ValueNotifier<bool> openDrawer = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: ((!Responsive.isDesktop(context)) ? 60 : 250),
      child: Container(
          decoration: const BoxDecoration(
            color: colorGreyLigth,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  const AppSpacing(),
                  Container(
                    height: 120,
                    margin: const EdgeInsets.only(bottom: appMargin),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: colorGrey))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(appPadding),
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Icon(
                                      Icons.person_outline_rounded,
                                      color: colorWhite,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Lucas",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Investidor",
                                        style: TextStyle(color: colorGreyDark),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: const Text("Dashboard"),
                        leading: const Icon(Icons.space_dashboard_rounded),
                        onTap: () {
                          AutoRouter.of(context).pushNamed("/");
                        },
                      ),
                      ListTile(
                        title: Text("Carteira"),
                        leading: const Icon(Icons.wallet_rounded),
                        onTap: () async {
                          SharedPreferences sharePref = await SharedPreferences.getInstance();
                          bool? selected = sharePref.getBool("selected");
                          AutoRouter.of(context).push(Wallet(active: selected!));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
