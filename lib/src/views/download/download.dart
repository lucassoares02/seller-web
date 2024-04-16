import 'package:auto_route/annotations.dart';
import 'package:profair/generated/l10n.dart';
import 'package:profair/src/controllers/download_controller.dart';
import 'package:profair/src/repositories/download_repository.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/views/download/components/list.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profair/src/views/home/home_controller.dart';

@RoutePage()
class Download extends StatefulWidget {
  Download({super.key, required this.homeController});

  HomeController homeController;

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  DownloadController? downloadController = DownloadController(StateApp.start, DownloadRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: colorSecondary),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: downloadController!.stateExport,
              builder: (context, value, child) {
                return ComponentList(
                  description: S.of(context).text_select_branch,
                  state: downloadController!.stateExport,
                  downloadController: downloadController!,
                  homeController: widget.homeController,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
