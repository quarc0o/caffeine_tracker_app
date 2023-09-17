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
            titlesData: FlTitlesData(show: false),
            minX: 0,
            maxX: caffeineValues.length.toDouble() - 1,
            minY: 0,
            maxY: caffeineValues.reduce(
                    (value, element) => value > element ? value : element) +
                1000, // Setting maximum Y to a bit more than the max caffeine value for better chart visibility.
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
