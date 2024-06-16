import 'package:flutter/material.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDropDownButton extends StatefulWidget {
  const AppDropDownButton({super.key, required this.function});

  final Function(String? value) function;

  @override
  State<AppDropDownButton> createState() => _AppDropDownButtonState();
}

class _AppDropDownButtonState extends State<AppDropDownButton> {
  String valueDropdown = "true";

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  getPreferences() async {
    try {
      SharedPreferences sharePref = await SharedPreferences.getInstance();
      String? drop = sharePref.getString("valuedrop");
      setState(() {
        valueDropdown = drop!;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: appPadding, vertical: 0),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(appRadius),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<dynamic>(
          focusColor: Colors.transparent,
          value: valueDropdown,
          items: const [
            DropdownMenuItem(value: "true", child: Text("Investimento Dinâmico")),
            DropdownMenuItem(value: "false", child: Text("Investimento Fixo")),
          ],
          onChanged: (value) async {
            SharedPreferences sharePref = await SharedPreferences.getInstance();
            sharePref.setString("valuedrop", value);
            setState(() {
              valueDropdown = value;
            });
            widget.function(value);
            return;
          },
        ),
      ),
    );
  }
}
