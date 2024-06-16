import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/format_currency.dart';
import 'package:profair/src/views/home/home_controller.dart';

class LineChartSample2All extends StatefulWidget {
  const LineChartSample2All({super.key, required this.homeController});

  final HomeController homeController;

  @override
  State<LineChartSample2All> createState() => _LineChartSample2AllState();
}

class _LineChartSample2AllState extends State<LineChartSample2All> {
  List<List<Color>> gradientColors = [
    [
      colorPrimary,
      colorSecondary,
    ],
    [
      Colors.orange,
      Colors.red,
    ],
    [
      Colors.pink,
      Colors.purple,
    ],
    [
      Colors.grey,
      Colors.amber,
    ],
    [
      Colors.brown,
      Colors.yellow,
    ],
    [
      Colors.green,
      Colors.blueAccent,
    ],
    [
      Colors.limeAccent,
      Colors.pinkAccent,
    ],
    [
      Colors.indigo,
      Colors.deepOrangeAccent,
    ],
    [
      Colors.deepPurpleAccent,
      Colors.blue,
    ],
    [
      Colors.yellow,
      Colors.orange,
    ],
    [
      colorPrimary,
      colorSecondary,
    ],
    [
      colorPrimary,
      colorSecondary,
    ],
    [
      colorPrimary,
      colorSecondary,
    ],
    [
      colorPrimary,
      colorSecondary,
    ],
    [
      colorPrimary,
      colorSecondary,
    ],
    [
      colorPrimary,
      colorSecondary,
    ],
    [
      colorPrimary,
      colorSecondary,
    ],
    [
      colorPrimary,
      colorSecondary,
    ],
    [
      colorPrimary,
      colorSecondary,
    ],
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            right: 15,
            left: 12,
            top: 24,
            bottom: 10,
          ),
          child: LineChart(
            mainData(),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );

    Widget text;

    final textValue = DateFormat("dd/MM").format(DateTime.parse(widget.homeController.historicListAll[1][(value).toInt()].data!));
    text = Text(textValue.toString(), style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );

    Widget text;

    final textValue = formatCurrency(value);
    text = Text(textValue, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.white,
            getTooltipItems: (List<LineBarSpot> barSpots) {
              return barSpots.map((e) {
                return LineTooltipItem(
                  "${widget.homeController.listSymbols[e.barIndex]} - ${formatCurrency(e.y)}",
                  const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                );
              }).toList();
            }),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 25,
        verticalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: colorGrey.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: colorGrey.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 10,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 85,
            interval: 900,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: (widget.homeController.historicListAll[0].length - 1).toDouble(),
      minY: 0,
      maxY: 100,
      lineBarsData: widget.homeController.historicListAll.asMap().entries.map((e) {
        return LineChartBarData(
          spots: e.value.asMap().entries.map((item) {
            return FlSpot(item.key.toDouble(), item.value.close!);
          }).toList(),
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors[e.key],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors[e.key].map((color) => color.withOpacity(0.01)).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }
}
