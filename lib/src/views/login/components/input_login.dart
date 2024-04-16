import 'package:flutter/material.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';

class InputLogin extends StatefulWidget {
  InputLogin({super.key, this.title, this.icon, this.maxLines = 1, this.maxLenght = 100, required this.controller});

  String? title;
  IconData? icon;
  int? maxLines;
  int? maxLenght;
  TextEditingController? controller;

  @override
  State<InputLogin> createState() => InputLoginState();
}

class InputLoginState extends State<InputLogin> {
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
          onChanged: (value) {},
          controller: widget.controller,
          // maxLength: widget.maxLenght,
          // maxLines: widget.maxLines,
          decoration: InputDecoration(
            filled: true,
            focusColor: colorSecondary,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(appRadius),
              ),
            ),
            fillColor: colorGreyLigth.withOpacity(0.5),
            hintText: "...",
          ),
        ),
      ],
    );
  }
}
