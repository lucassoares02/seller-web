import 'package:auto_route/auto_route.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/controllers/settings_controller.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/material.dart';

class CardNotice extends StatefulWidget {
  CardNotice({super.key, required this.settingsController});

  SettingsController settingsController;

  @override
  State<CardNotice> createState() => _CardNoticeState();
}

class _CardNoticeState extends State<CardNotice> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed("/listattractions");
        AutoRouter.of(context).pushNamed("/app/listattractions");
      },
      child: ValueListenableBuilder(
          valueListenable: widget.settingsController.updateInput,
          builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: appPadding),
              padding: const EdgeInsets.all(20),
              width: double.maxFinite,
              height: 400,
              decoration: BoxDecoration(
                // color: colorTertiary,
                // color: Color(int.parse(widget.settingsController.documents!.documents.first.data["color"])),
                color: Color(int.parse(widget.settingsController.colorNotice.text)),
                borderRadius: BorderRadius.circular(appRadius),
                // image: const DecorationImage(
                //   fit: BoxFit.cover,
                //   opacity: 0.2,
                //   image: NetworkImage(
                //     "https://images.pexels.com/photos/1855214/pexels-photo-1855214.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                //   ),
                // ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Image.asset(
                  //   fit: BoxFit.contain,
                  //   'assets/images/logo-client.png',
                  // ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: appMargin * 2, vertical: 5),
                        decoration: BoxDecoration(
                          color: Color(int.parse(widget.settingsController.stampColorNotice.text)),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.event,
                              size: 18,
                              color: colorWhite,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.settingsController.stampNotice.text,
                              style: const TextStyle(
                                color: colorWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.settingsController.titleNotice.text,
                            style: const TextStyle(
                              fontSize: 26,
                              color: colorBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const AppSpacing(),
                          Text(
                            widget.settingsController.legendNotice.text,
                            style: const TextStyle(
                              fontSize: 16,
                              color: colorWhite,
                            ),
                          ),
                        ],
                      ),
                      const AppSpacing(),
                      Container(
                        width: double.maxFinite,
                        height: 37,
                        decoration: const BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(appRadius))),
                        child: Center(
                            child: Text(
                          widget.settingsController.descriptionButtonNotice.text,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  ),
                ],
              ),
              // child: FittedBox(
              //   fit: BoxFit.none,
              //   alignment: Alignment.bottomCenter,
              //   child: Image.network(
              //     'assets/images/people.png',
              //     height: 150,
              //   ),
              // ),
            );
          }),
    );
  }
}
