import 'package:flutter/material.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/shared/responsive.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/views/home/home_controller.dart';

class ItemBalance extends StatefulWidget {
  ItemBalance({
    super.key,
    required this.title,
    required this.iconTip,
    required this.valueTip,
    required this.value,
    required this.color,
    required this.index,
  });

  String title;
  String value;
  String valueTip;
  IconData iconTip;
  Color color;
  int index;

  @override
  State<ItemBalance> createState() => _ItemBalanceState();
}

class _ItemBalanceState extends State<ItemBalance> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(right: widget.index == 3 ? 0 : appPadding),
        decoration: BoxDecoration(color: colorGreyLigth.withOpacity(0.2), borderRadius: const BorderRadius.all(Radius.circular(appRadius))),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(appPadding * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                    if (!Responsive.isSmallTablet(context))
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: appPadding, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(appRadius)),
                          color: widget.color.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              widget.iconTip,
                              color: widget.color,
                              size: 20,
                            ),
                            Text(
                              widget.valueTip,
                              style: TextStyle(color: widget.color),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
                const AppSpacing(),
                Text(
                  widget.value,
                  style: TextStyle(fontSize: Responsive.isDesktop(context) ? 28 : 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          // )
        ),
      ),
    );
  }
}
