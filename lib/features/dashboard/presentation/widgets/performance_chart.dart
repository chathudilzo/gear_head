import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gear_head/core/theme/app_colors.dart';

class PerformanceChart extends StatelessWidget {
  final List<FlSpot> rpmPoints;
  const PerformanceChart({super.key, required this.rpmPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      padding: EdgeInsets.only(top: 20, right: 20, left: 10),
      decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white)),
      child: LineChart(
          duration: Duration(milliseconds: 250),
          curve: Curves.linear,
          LineChartData(
              minX: rpmPoints.isEmpty ? 0 : rpmPoints.first.x,
              maxX: rpmPoints.isEmpty ? 50 : rpmPoints.last.x,
              minY: 0,
              maxY: 8000,
              gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2000,
                  getDrawingHorizontalLine: (value) =>
                      FlLine(color: Colors.white, strokeWidth: 1)),
              titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2000,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) => Text(
                                '${value.toInt()}',
                                style: const TextStyle(
                                    color: Colors.white38, fontSize: 10),
                              )))),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                    show: true,
                    spots: rpmPoints,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: AppColors.primaryAccent,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                            colors: [
                              AppColors.primaryAccent.withOpacity(0.3),
                              AppColors.primaryAccent.withOpacity(0.0)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)))
              ])),
    );
  }
}
