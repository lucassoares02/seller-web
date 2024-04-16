import 'package:auto_route/auto_route.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/router/router.gr.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/format_currency.dart';
import 'package:profair/src/views/home/state_management.dart';
import 'package:profair/src/views/home/home_controller.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:skeletons/skeletons.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
    widget.homeController.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ValueListenableBuilder(
      valueListenable: widget.homeController.stateBuyers,
      builder: (context, value, _) {
        return StateManagement(
          width: width,
          listenable: widget.homeController.stateBuyers,
          widgetLoading: Row(
              children: [1, 2, 3, 4, 5].map((e) {
            return Flexible(
              flex: 1,
              child: Row(
                children: [
                  if (e != 1) const AppSpacing(),
                  Expanded(
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(height: 150, borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            );
          }).toList()),
          component: Container(
            child: Column(
              children: [
                Row(
                    children: widget.homeController.buyers.asMap().entries.map((e) {
                  return Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        AutoRouter.of(context).push(Providers(codeClient: 0, codeBranch: 0, codeBuyer: e.value.codeBuyer));
                      },
                      child: Container(
                        height: 150,
                        padding: const EdgeInsets.all(appPadding),
                        margin: EdgeInsets.only(left: appMargin, right: e.key == widget.homeController.buyers.length - 1 ? appMargin : 0),
                        decoration: const BoxDecoration(color: colorSecondary, borderRadius: BorderRadius.all(Radius.circular(appRadius))),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.handshake_rounded,
                                  color: colorWhite.withOpacity(0.7),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  // '${widget.homeController.buyers[index].nameBuyer}',
                                  '${e.value.category}',
                                  style: const TextStyle(
                                    color: colorWhite,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  formatCurrency(e.value.total!),
                                  style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: colorWhite,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList()),
              ],
            ),
          ),
        );
      },
    );
  }
}
