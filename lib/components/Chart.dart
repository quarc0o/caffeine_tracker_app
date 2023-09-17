import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<double> caffeineValues;

  const Chart({Key? key, required this.caffeineValues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      width: 310,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 300,
        height: 200,
        child: LineChart(
          LineChartData(
            backgroundColor: Colors.white,
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
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
                barWidth: 6,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 2:
      text = const Text('MAR', style: style);
      break;
    case 5:
      text = const Text('JUN', style: style);
      break;
    case 8:
      text = const Text('SEP', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = '10K';
      break;
    case 3:
      text = '30k';
      break;
    case 5:
      text = '50k';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
