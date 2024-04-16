import 'package:auto_route/annotations.dart';
import 'package:profair/generated/l10n.dart';
import 'package:profair/src/components/loading_dash.dart';
import 'package:profair/src/controllers/upload_controller.dart';
import 'package:profair/src/repositories/upload_repository.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/views/home/components/card_charts.dart';
import 'package:profair/src/views/upload/components/list.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  UploadController? uploadController;

  @override
  void initState() {
    uploadController = UploadController(StateApp.start, UploadRepository());

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
              valueListenable: uploadController!.stateUpload,
              builder: (context, value, child) {
                return ComponentList(
                  description: S.of(context).text_select_branch,
                  state: uploadController!.stateUpload,
                  uploadController: uploadController!,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
