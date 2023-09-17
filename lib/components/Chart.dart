import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final List<FlSpot> caffeineData = [
    FlSpot(0, 45),
    FlSpot(1, 80),
    FlSpot(2, 38),
    FlSpot(3, 25),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310, // Increased to account for the padding
      height: 210, // Increased to account for the padding
      decoration: BoxDecoration(
        color: Colors.white, // This gives the background color
        borderRadius:
            BorderRadius.circular(16), // This gives the rounded borders
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(
          5), // Giving some padding to see the shadow properly
      child: SizedBox(
        width: 300,
        height: 200,
        child: LineChart(
          LineChartData(
            backgroundColor: Colors.white,
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            minX: 0,
            maxX: 3, // adjusted to the max x-value you provided
            minY: 0,
            maxY: 100,
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
