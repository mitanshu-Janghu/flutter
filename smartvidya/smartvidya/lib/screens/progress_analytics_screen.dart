import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressAnalyticsScreen extends StatelessWidget {
  const ProgressAnalyticsScreen({super.key});

  List<FlSpot> getData() {
    return [
      FlSpot(0, 20),
      FlSpot(1, 35),
      FlSpot(2, 15),
      FlSpot(3, 40),
      FlSpot(4, 60),
      FlSpot(5, 50),
      FlSpot(6, 70),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        title: const Text("Progress Analytics"),
        backgroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Weekly Study Progress",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),

                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {

                          const days = [
                            "Mon","Tue","Wed","Thu","Fri","Sat","Sun"
                          ];

                          return Text(
                            days[value.toInt()],
                            style: const TextStyle(color: Colors.white54),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),

                  borderData: FlBorderData(show: true),

                  lineBarsData: [
                    LineChartBarData(
                      spots: getData(),
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 4,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "You studied 290 minutes this week",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
