// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/components/loading_chart.dart';
import 'package:profair/src/components/progress_indicator.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/views/home/home_controller.dart';

@RoutePage()
class CountPage extends StatefulWidget {
  CountPage({super.key, required this.homeController});

  HomeController homeController;

  @override
  State<CountPage> createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  bool visible = false;
  double _value = 0.0;
  @override
  void initState() {
    super.initState();
    getValueFairTotal();
  }

  getValueFairTotal() async {
    await widget.homeController.findValueFair();
  }

  void goFullScreen() {
    if (visible) {
      document.exitFullscreen();
    } else {
      document.documentElement?.requestFullscreen();
    }
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: colorWhite),
      child: ValueListenableBuilder(
          valueListenable: widget.homeController.stateValueFair,
          builder: ((context, value, child) {
            return value == StateApp.loading
                ? LoadingChart()
                : GestureDetector(
                    // onTap: () => goFullScreen(),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              AnimatedFlipCounter(
                                duration: const Duration(seconds: 1),
                                value: widget.homeController.valueFair!,
                                fractionDigits: 2, // decimal precision
                                decimalSeparator: ',',
                                // curve: Curves.bounceIn,
                                thousandSeparator: '.',
                                // prefix: "R\$",
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Sf',
                                  fontWeight: FontWeight.bold,
                                  color: colorBlack,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
            // return value == StateApp.loading
            //     ? Container()
            //     : Center(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             FittedBox(
            //               fit: BoxFit.fitWidth,
            //               child: AnimatedFlipCounter(
            //                 duration: Duration(seconds: 2),
            //                 value: widget.homeController.balance!.documents.first.data["value"],
            //                 fractionDigits: 2, // decimal precision
            //                 prefix: "R\$",
            //                 textStyle: const TextStyle(
            //                   decoration: TextDecoration.none,
            //                   fontFamily: 'Sf',
            //                   fontWeight: FontWeight.bold,
            //                   color: colorBlack,
            //                 ),
            //               ),
            //             ),
            //             TextButton(
            //                 onPressed: (() => goFullScreen()),
            //                 child: const Text(
            //                   "Tela Cheia",
            //                 ))
            //           ],
            //         ),
            //       );
          })),
    );
  }
}
