import 'package:profair/src/components/progress_indicator.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, this.label, this.type, this.colorButton, this.iconButton, required this.onPressButton, this.loading = false});

  final String? label;
  final String? type;
  final Color? colorButton;
  final IconData? iconButton;
  final Function()? onPressButton;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final witdh = MediaQuery.of(context).size.width;
    const SizedBox marginWidget = SizedBox(width: appMargin);

    return SizedBox(
      height: 50,
      width: 200,
      child: TextButton(
          onPressed: loading ? null : onPressButton,
          style: ElevatedButton.styleFrom(
            backgroundColor: type == 'filled' ? colorWhite : colorButton ?? colorPrimary,
            foregroundColor: type == 'filled' ? colorGrey : colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appRadius),
              side: BorderSide(color: type == 'filled' ? colorButton ?? colorPrimary : transparent, width: 2),
            ),
          ),
          child: loading
              ? Center(child: AppProgressIndicator())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconButton,
                      color: type == 'filled' ? colorButton : colorWhite,
                    ),
                    if (iconButton != null) marginWidget,
                    Text(
                      '$label',
                      style: TextStyle(
                        color: type == 'filled' ? colorButton ?? colorPrimary : colorWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
    );
  }
}
