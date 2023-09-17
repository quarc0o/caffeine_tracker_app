import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<double> caffeineValues;

  const Chart({Key? key, required this.caffeineValues}) : super(key: key);

  String getHourString(int index) {
    final now = DateTime.now();
    final targetTime =
        now.add(Duration(hours: index * 2)); // adding 2 hours for each step
    return DateFormat('HH:mm').format(targetTime);
  }

  @override
  Widget build(BuildContext context) {
    const int maxXTitles = 5; // For example, 5 titles on the x-axis
    const int maxYTitles = 4; // For example, 4 titles on the y-axis

    List<FlSpot> caffeineData = List.generate(caffeineValues.length, (index) {
      return FlSpot(index.toDouble(), caffeineValues[index]);
    });

    double maxValue = caffeineValues.isEmpty
        ? 0
        : caffeineValues
            .reduce((value, element) => value > element ? value : element);
    double intervalValue = maxValue / 5;
    if (intervalValue == 0) intervalValue = 1;

    return Container(
        width: 330,
        height: 210,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.all(5),
        child: Align(
          alignment: Alignment.centerRight,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  maxContentWidth: 100,
                  tooltipBgColor: Colors.black,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((LineBarSpot touchedSpot) {
                      final textStyle = TextStyle(
                        color: touchedSpot.bar.gradient?.colors[0] ??
                            touchedSpot.bar.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      );
                      return LineTooltipItem(
                        '${touchedSpot.y.toStringAsFixed(0)} mg',
                        textStyle,
                      );
                    }).toList();
                  },
                ),
                handleBuiltInTouches: true,
                getTouchLineStart: (data, index) => 0,
                getTouchLineEnd: (data, index) => 0,
              ),
              clipData: const FlClipData.all(),
              backgroundColor: Colors.white,
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(
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
                    getTitlesWidget: bottomTitleWidgets,
                    reservedSize: 30,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: leftTitleWidgets,
                    reservedSize: 50,
                  ),
                ),
              ),
              minX: 0,
              maxX: caffeineValues.length.toDouble() - 1,
              minY: 0,
              maxY: caffeineValues.reduce(
                      (value, element) => value > element ? value : element) +
                  10, // Setting maximum Y to a bit more than the max caffeine value for better chart visibility.
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: caffeineData,
                  isCurved: true,
                  curveSmoothness: 1,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                  dotData: const FlDotData(show: false),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  final style = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 10,
  );
  String getHourString(int index) {
    final now = DateTime.now();
    final targetTime =
        now.add(Duration(hours: index * 2)); // adding 2 hours for each step
    return DateFormat('HH:mm').format(targetTime);
  }

  String text = getHourString(value.toInt());

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(text, style: style),
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  final style = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );

  // Format the Y-value as a string
  String text;
  if (value % 1 == 0) {
    // Check if the value is an integer
    text = '${value.toInt()} mg'; // Convert to integer and add 'K' postfix
  } else {
    text = '${value.toStringAsFixed(1)} mg'; // Keep one decimal point if needed
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(text, style: style),
  );
}
