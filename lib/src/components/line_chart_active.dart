import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profair/src/models/historic_model.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/utils/format_currency.dart';

class LineChartActiveSample2 extends StatefulWidget {
  const LineChartActiveSample2({super.key, required this.historic, required this.maxValue});

  final List<HistoricModel> historic;
  final double maxValue;

  @override
  State<LineChartActiveSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartActiveSample2> {
  List<Color> gradientColors = [
    colorPrimary,
    colorSecondary,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    inspect(widget.historic);
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

    final textValue = DateFormat("dd/MM").format(DateTime.parse(widget.historic[(value).toInt()].date!));
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
                  formatCurrency(widget.historic[(e.x).toInt()].close!),
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
        horizontalInterval: 40,
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
            interval: 5,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 85,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: (widget.historic.length - 1).toDouble(),
      minY: 0,
      maxY: widget.maxValue + 10,
      lineBarsData: [
        LineChartBarData(
          spots: widget.historic.asMap().entries.map((item) {
            return FlSpot(item.key.toDouble(), item.value.close!);
          }).toList(),
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
