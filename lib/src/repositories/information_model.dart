import 'package:flutter/material.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/format_currency.dart';

class InformationModel {
  String? total;
  String? title;
  String? addInfo;
  IconData? icon;
  Color? color;

  InformationModel({
    this.total,
    this.title,
    this.addInfo,
    this.icon,
    this.color,
  });

  InformationModel.fromJson(Map<String, dynamic> json, int index) {
    final listIcons = [Icons.swap_vert_sharp, Icons.storefront_sharp, Icons.business_rounded, Icons.shopping_cart_outlined];
    List<Color> colors = [colorPrimary, colorSecondary, colorTertiary, colorGreen];
    title = json['title'].toString();
    total = index == 0 ? formatCurrency(json['total']) : json['total'].toString();
    icon = listIcons[index];
    color = colors[index];
    addInfo = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['title'] = title;
    data['addInfo'] = addInfo;
    data['icon'] = icon;
    data['color'] = color;
    return data;
  }
}
