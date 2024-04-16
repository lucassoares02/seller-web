import 'package:profair/src/components/header_list.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/controllers/settings_controller.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/settings/components/alert.dart';
import 'package:profair/src/views/settings/components/notice.dart';

class ComponentList extends StatefulWidget {
  const ComponentList({
    super.key,
    this.description,
    required this.state,
    required this.settingsController,
  });

  final String? description;
  final ValueListenable state;
  final SettingsController settingsController;

  @override
  State<ComponentList> createState() => _ComponentListState();
}

class _ComponentListState extends State<ComponentList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderList(
          icon: Icons.store_mall_directory_outlined,
          activeSearch: false,
          label: "Configurações",
        ),
        Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: colorGreyLigth.withOpacity(0.5),
            ),
            padding: const EdgeInsets.all(appPadding),
            child: Column(
              children: [
                SessionAlert(settingsController: widget.settingsController),
                const AppSpacing(),
                const AppSpacing(),
                const AppSpacing(),
                SessionNotice(settingsController: widget.settingsController)
              ],
            )),
      ],
      // ),
    );
  }
}
