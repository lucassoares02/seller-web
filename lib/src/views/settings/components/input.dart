import 'package:flutter/material.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/controllers/settings_controller.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';

class InputComponent extends StatefulWidget {
  InputComponent({super.key, this.title, this.icon, this.maxLines = 1, this.maxLenght = 100, required this.controller, this.settingsController});

  String? title;
  IconData? icon;
  int? maxLines;
  int? maxLenght;
  TextEditingController? controller;
  SettingsController? settingsController;

  @override
  State<InputComponent> createState() => InputComponentState();
}

class InputComponentState extends State<InputComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              widget.icon,
              color: colorGrey,
            ),
            const AppSpacing(),
            Text(
              widget.title!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        TextFormField(
          onChanged: (value) {
            if (widget.settingsController != null) {
              widget.settingsController!.updateInput.value = !widget.settingsController!.updateInput.value;
            }
          },
          controller: widget.controller,
          maxLength: widget.maxLenght,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            filled: true,
            focusColor: colorSecondary,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(appRadius),
              ),
            ),
            fillColor: colorGreyLigth.withOpacity(0.2),
            hintText: "...",
          ),
        ),
      ],
    );
  }
}
