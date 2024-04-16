import 'package:profair/src/components/spacing.dart';

import 'package:skeletons/skeletons.dart';
import 'package:flutter/material.dart';

class LoadingChart extends StatefulWidget {
  LoadingChart({super.key, this.index});

  int? index;

  @override
  State<LoadingChart> createState() => _LoadingChartState();
}

class _LoadingChartState extends State<LoadingChart> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        child: Row(
          children: [
            if (widget.index != 1) const AppSpacing(),
            Expanded(
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(height: 400, borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
