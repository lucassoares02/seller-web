import 'package:auto_route/annotations.dart';
import 'package:profair/provider/appwriter.dart';
import 'package:profair/src/components/progress_indicator.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/views/home/components/card_charts.dart';
import 'package:profair/src/views/home/components/card_welcome.dart';
import 'package:profair/src/views/home/components/categories.dart';
import 'package:profair/src/views/home/components/last_requests.dart';
import 'package:profair/src/views/home/components/notices.dart';
import 'package:profair/src/views/home/home_controller.dart';
import 'package:profair/src/components/loading_list.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

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
    homeController!.findNotices();
    homeController!.findInformationHome();
    homeController!.findChartPorMinute();
    homeController!.findChart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppSpacing(),
                    const AppSpacing(),
                    const AppSpacing(),
                    CardWelcome(homeController: homeController!),
                    CardCharts(homeController: homeController!),
                    // ValueListenableBuilder(
                    //     valueListenable: homeController!.stateInformation,
                    //     builder: (context, value, child) {
                    //       return value == StateApp.loading ? LoadingDash() : CardCharts(homeController: homeController);
                    //     }),
                    // ValueListenableBuilder(
                    //     valueListenable: homeController!.stateNoticesAppWrite,
                    //     builder: (context, value, child) {
                    //       return value == StateApp.loading
                    //           ? Container(
                    //               margin: const EdgeInsets.symmetric(horizontal: appPadding),
                    //               child: SkeletonAvatar(
                    //                 style: SkeletonAvatarStyle(height: 300, width: width, borderRadius: BorderRadius.circular(10)),
                    //               ),
                    //             )
                    //           : CardNotice(homeController: homeController);
                    //     }),
                    // CardCount(homeController: homeController),
                    // const AppSpacing(),
                    // AppActions(homeController: homeController),
                    // const AppSpacing(),
                    const AppSpacing(),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: appPadding),
                    //   child: ValueListenableBuilder(
                    //       valueListenable: homeController!.stateData,
                    //       builder: (context, value, child) {
                    //         return value == StateApp.loading
                    //             ? Row(
                    //                 children: [1, 2, 3, 4, 5].map((e) {
                    //                 return Flexible(
                    //                   flex: 1,
                    //                   child: Row(
                    //                     children: [
                    //                       if (e != 1) const AppSpacing(),
                    //                       Expanded(
                    //                         child: SkeletonAvatar(
                    //                           style: SkeletonAvatarStyle(height: 150, borderRadius: BorderRadius.circular(10)),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 );
                    //               }).toList())
                    //             : homeController!.data!.accessTargeting == 3
                    //                 ? Column(
                    //                     children: [
                    //                       Categories(homeController: homeController!),
                    //                     ],
                    //                   )
                    //                 : Container();
                    //       }),
                    // ),
                    // const AppSpacing(),
                    // const AppSpacing(),
                    // ValueListenableBuilder(
                    //   valueListenable: homeController!.stateAlert,
                    //   builder: (context, value, child) {
                    //     return value == StateApp.loading
                    //         ? AppProgressIndicator()
                    //         : Notices(
                    //             listItems: homeController!.alerts!,
                    //             state: homeController!.stateAlert,
                    //             title: S.of(context).text_notifications,
                    //             cardHeigth: 90,
                    //             cardWidth: 340,
                    //           );
                    //   },
                    // ),
                    const AppSpacing(),
                    ValueListenableBuilder(
                      valueListenable: homeController!.stateData,
                      builder: (context, value, child) {
                        return value == StateApp.loading
                            ? LoadingList(loadingHeader: false)
                            : homeController!.data!.accessTargeting == 1
                                ? LastRequests(
                                    description: S.of(context).text_last_orders,
                                    listItems: homeController!.requestStores,
                                    state: homeController!.stateRequestsStore,
                                  )
                                : Container();
                      },
                    )
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
