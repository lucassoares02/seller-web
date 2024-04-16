import 'package:profair/src/components/header_list.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/controllers/upload_controller.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/upload/components/item_upload_company.dart';
import 'package:profair/src/views/upload/components/item_upload_merchandise.dart';
import 'package:profair/src/views/upload/components/item_upload_negotiation.dart';
import 'package:profair/src/views/upload/components/item_upload_people.dart';

class ComponentList extends StatefulWidget {
  const ComponentList({
    super.key,
    this.description,
    required this.state,
    required this.uploadController,
  });

  final String? description;
  final ValueListenable state;
  final UploadController uploadController;

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
          icon: Icons.upload_file_rounded,
          activeSearch: false,
          label: "Importações",
        ),
        Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: colorGreyLigth.withOpacity(0.5),
            ),
            padding: const EdgeInsets.all(appPadding),
            child: Column(
              children: [
                ItemUpload(uploadController: widget.uploadController),
                const AppSpacing(),
                ItemUploadPeople(uploadController: widget.uploadController),
                const AppSpacing(),
                ItemUploadMerchandise(uploadController: widget.uploadController),
                const AppSpacing(),
                ItemUploadNegotiation(uploadController: widget.uploadController),
              ],
            )),
      ],
      // ),
    );
  }
}
