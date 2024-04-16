import 'package:auto_route/annotations.dart';
import 'package:profair/generated/l10n.dart';
import 'package:profair/provider/appwriter.dart';
import 'package:profair/src/controllers/settings_controller.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/views/settings/components/list.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

@RoutePage()
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsController? settingsController;

  @override
  void initState() {
    settingsController = SettingsController(StateApp.start, Provider.of<AppWrite>(context, listen: false));
    settingsController!.findAlert();
    settingsController!.findNotice();
    settingsController!.findNoticeRealTime();

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
              valueListenable: settingsController!.stateFind,
              builder: (context, value, child) {
                return ComponentList(
                  description: S.of(context).text_select_branch,
                  state: settingsController!.stateFind,
                  settingsController: settingsController!,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
