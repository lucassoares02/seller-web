import 'package:profair/src/components/header_list.dart';
import 'package:profair/src/components/loading_chart.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:skeletons/skeletons.dart';
import 'package:flutter/material.dart';

class LoadingDash extends StatefulWidget {
  LoadingDash({super.key, this.label, this.icon, this.loadingHeader = true});

  String? label;
  IconData? icon;
  bool loadingHeader;

  @override
  State<LoadingDash> createState() => _LoadingDashState();
}

class _LoadingDashState extends State<LoadingDash> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        children: [
          Row(
              children: [1, 2, 3, 4].map((e) {
            return Flexible(
              flex: 1,
              child: Container(
                child: Row(
                  children: [
                    if (e != 1) const AppSpacing(),
                    Expanded(
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(height: 150, borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
          // const AppSpacing(),
          // Row(
          //     children: [1, 2].map((e) {
          //   return LoadingChart(index: e);
          // }).toList()),
        ],
      ),
    );
  }
}
