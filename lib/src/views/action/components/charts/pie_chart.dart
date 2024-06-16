// import 'dart:developer';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:profair/src/shared/responsive.dart';
// import 'package:profair/src/utils/colors.dart';
// import 'package:profair/src/utils/format_currency.dart';
// import 'package:profair/src/utils/spacing.dart';
// import 'package:profair/src/views/home/components/charts/indicator.dart';
// import 'package:profair/src/views/home/home_controller.dart';

// class PieChartSample2 extends StatefulWidget {
//   PieChartSample2({super.key, required this.homeController});

//   HomeController homeController;

//   @override
//   State<StatefulWidget> createState() => PieChart2State();
// }

// class PieChart2State extends State<PieChartSample2> {
//   int touchedIndex = -1;

//   List<Color> colors = [
//     colorPrimary,
//     colorSecondary,
//     colorTertiary,
//     colorRed,
//     colorGrey,
//     colorGreyDark,
//     colorBlue,
//     colorGreen,
//     colorBlack,
//     colorCyan,
//     colorPurple
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         Expanded(
//           child: PieChart(
//             PieChartData(
//               pieTouchData: PieTouchData(
//                 touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                   setState(() {
//                     if (!event.isInterestedForInteractions ||
//                         pieTouchResponse == null ||
//                         pieTouchResponse.touchedSection == null) {
//                       touchedIndex = -1;
//                       return;
//                     }
//                     touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
//                   });
//                 },
//               ),
//               borderData: FlBorderData(
//                 show: false,
//               ),
//               sectionsSpace: 0,
//               centerSpaceRadius: 80,
//               sections: showingSections(),
//             ),
//           ),
//         ),
//         // Column(
//         //     mainAxisAlignment: MainAxisAlignment.end,
//         //     crossAxisAlignment: CrossAxisAlignment.start,
//         //     children: widget.homeController.chartClient.asMap().entries.map((e) {
//         //       return Column(
//         //         children: [
//         //           Indicator(
//         //             color: colors[e.key],
//         //             text: e.value.client!,
//         //             isSquare: false,
//         //           ),
//         //         ],
//         //       );
//         //     }).toList()),
//       ],
//     );
//   }

//   List<PieChartSectionData>? showingSections() {
//     return widget.homeController.chartClient.asMap().entries.map((item) {
//       final isTouched = item.key == touchedIndex;
//       const fontSize = 16.0;
//       final radius = isTouched ? 60.0 : 50.0;
//       const style = TextStyle(fontSize: fontSize, color: colorWhite);

//       return PieChartSectionData(
//         badgeWidget: isTouched
//             ? Container(
//                 decoration:
//                     BoxDecoration(color: colors[item.key], borderRadius: BorderRadius.all(Radius.circular(radius))),
//                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: appPadding),
//                 child: Text(
//                   "${item.value.client!} - ${formatCurrency(item.value.value!)}",
//                   style: style,
//                 ),
//               )
//             : Container(),
//         color: colors[item.key],
//         value: double.parse(item.value.percentage!.replaceAll("%", "")),
//         title: isTouched ? "" : item.value.percentage,
//         radius: radius,
//         titleStyle: style,
//       );
//     }).toList();
//   }
// }
