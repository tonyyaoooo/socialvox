import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample extends StatelessWidget {
  final List<double> values;

  const LineChartSample({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: 0,
        maxX: values.length.toDouble() - 1,
        minY: 0,
        maxY: values.reduce((max, value) => value > max ? value : max).toDouble() + 10,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(values.length, (index) => FlSpot(index.toDouble(), values[index])),
            isCurved: true,
            colors: [Colors.blue],
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true),
          ),
        ],
      ),
    );
  }
}
