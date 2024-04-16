import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:profair/src/controllers/settings_controller.dart';
import 'package:profair/src/views/home/state_management.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:skeletons/skeletons.dart';
import 'package:flutter/material.dart';

class Alerts extends StatefulWidget {
  const Alerts({
    super.key,
    this.cardWidth,
    this.cardHeigth,
    this.title,
    required this.listItems,
    required this.state,
    required this.settingsController,
  });

  final String? title;
  final double? cardWidth;
  final double? cardHeigth;
  final ValueNotifier<StateApp> state;
  final DocumentList? listItems;
  final SettingsController settingsController;

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return StateManagement(
      width: width,
      listenable: widget.state,
      widgetLoading: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(left: appPadding, bottom: appMargin),
              child: SkeletonLine(
                style: SkeletonLineStyle(width: width / 2, height: 15, borderRadius: const BorderRadius.all(Radius.circular(10))),
              )),
          Container(
            margin: const EdgeInsets.only(left: 5),
            height: widget.cardHeigth ?? 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: appMargin, right: appPadding, top: appMargin),
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        height: widget.cardHeigth ?? 300,
                        width: widget.cardWidth ?? 200,
                        borderRadius: BorderRadius.circular(appRadius),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      component: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: widget.cardHeigth ?? 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.listItems!.total,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (!widget.settingsController.visibleForm.value) {
                        widget.settingsController.visibleForm.value = !widget.settingsController.visibleForm.value;
                      }
                      widget.settingsController.title.text = widget.listItems!.documents[index].data["title"];
                      widget.settingsController.priority.text = widget.listItems!.documents[index].data["priority"].toString();
                      widget.settingsController.time.text = widget.listItems!.documents[index].data["time"];
                      widget.settingsController.description.text = widget.listItems!.documents[index].data["description"];
                      widget.settingsController.idAlert.value = widget.listItems!.documents[index].$id;
                      // Navigator.of(context).pushNamed('detailsrecipe', arguments: widget.listItems[index]);
                    },
                    child: Container(
                      width: widget.cardWidth ?? 200,
                      decoration: const BoxDecoration(
                        color: colorGreyLigth,
                        borderRadius: BorderRadius.all(Radius.circular(appRadius)),
                      ),
                      padding: const EdgeInsets.only(
                        top: appMargin / 1.7,
                        bottom: appMargin / 1.7,
                        right: appMargin / 1.7,
                      ),
                      margin: EdgeInsets.only(left: index == 0 ? appPadding * 3 : appPadding, right: (widget.listItems!.total - 1 == index) ? appPadding : 0),
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              color: widget.listItems!.documents[index].data["priority"] == 5
                                  ? colorRed
                                  : widget.listItems!.documents[index].data["priority"] == 4
                                      ? colorTertiary
                                      : colorGreyDark,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(appRadius),
                                bottomLeft: Radius.circular(appRadius),
                              ),
                            ),
                          ),
                          const SizedBox(width: appMargin),
                          Container(
                            width: 60,
                            height: 60,
                            // padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: widget.listItems!.documents[index].data["priority"] == 5
                                  ? colorRed
                                  : widget.listItems!.documents[index].data["priority"] == 4
                                      ? colorTertiary
                                      : colorGreyDark,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: const Icon(
                              Icons.notifications_none_rounded,
                              color: colorWhite,
                              size: 30,
                            ),
                          ),
                          const AppSpacing(),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.listItems!.documents[index].data["title"],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                Text(
                                  widget.listItems!.documents[index].data["description"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
