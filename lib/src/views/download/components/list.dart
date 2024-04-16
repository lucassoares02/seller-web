import 'package:profair/src/components/header_list.dart';
import 'package:profair/src/controllers/download_controller.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/download/components/item_downpload_client.dart';
import 'package:profair/src/views/download/components/item_downpload_company.dart';
import 'package:profair/src/views/home/home_controller.dart';

class ComponentList extends StatefulWidget {
  const ComponentList({
    super.key,
    this.description,
    required this.state,
    required this.downloadController,
    required this.homeController,
  });

  final String? description;
  final ValueListenable state;
  final DownloadController downloadController;
  final HomeController homeController;

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
          icon: Icons.download,
          activeSearch: false,
          label: "Exportações",
        ),
        Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: colorGreyLigth.withOpacity(0.5),
            ),
            padding: const EdgeInsets.all(appPadding),
            child: Column(
              children: [
                widget.homeController.data!.accessTargeting == 3
                    ? ItemDownload(downloadController: widget.downloadController)
                    : ItemDownloadClient(
                        downloadController: widget.downloadController,
                        homeController: widget.homeController,
                      ),
              ],
            )),
      ],
      // ),
    );
  }
}
