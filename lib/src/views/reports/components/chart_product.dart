import 'package:profair/src/models/total_value_clients.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartTeste extends StatefulWidget {
  BarChartTeste({super.key, required this.reportsClients});

  List<TotalValueClients> reportsClients;

  final Color barBackgroundColor = transparent;
  final Color barColor = colorSecondary;
  final Color touchedBarColor = colorTertiary;

  @override
  State<StatefulWidget> createState() => BarChartTesteState();
}

class BarChartTesteState extends State<BarChartTeste> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  String formatCurrency(double amount) {
    String formattedAmount = amount.toStringAsFixed(2);
    formattedAmount = formattedAmount.replaceAll('.', ',');
    List<String> parts = formattedAmount.split(',');
    String integerPart = parts[0];
    String decimalPart = parts[1];

    String formattedIntegerPart = '';
    for (int i = integerPart.length - 1, count = 0; i >= 0; i--, count++) {
      if (count != 0 && count % 3 == 0) {
        formattedIntegerPart = ".$formattedIntegerPart";
      }
      formattedIntegerPart = integerPart[i] + formattedIntegerPart;
    }

    return 'R\$$formattedIntegerPart,$decimalPart';
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(mainBarData());
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: colorGreyDark,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: 5,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              "${widget.reportsClients[group.x].client!}\n\n",
              const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: formatCurrency(rod.toY - 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions || barTouchResponse == null || barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
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
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 80, interval: (widget.reportsClients[0].total! / 5)),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: true, drawVerticalLine: false),
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(widget.reportsClients.length < 20 ? widget.reportsClients.length : 20, (e) {
        return makeGroupData(e, widget.reportsClients[e].total!, isTouched: e == touchedIndex);
      });

  BarChartGroupData makeGroupData(int x, double y, {bool isTouched = false, Color? barColor, double width = 15, List<int> showTooltips = const []}) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 0 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched ? BorderSide(color: widget.touchedBarColor) : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: colorBlue,
      fontSize: 14,
    );
    Widget text;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 20,
      child: Text(widget.reportsClients[value.toInt()].client!.substring(0, 1), style: style),
    );
  }
}
