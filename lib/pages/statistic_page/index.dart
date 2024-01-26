import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Graph and Cards'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Graph
            Container(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10,
                  barGroups: [
                    makeGroupData(0, 8, Colors.blue),
                    makeGroupData(1, 5, Colors.green),
                    makeGroupData(2, 7, Colors.orange),
                    makeGroupData(3, 2, Colors.red),
                    makeGroupData(4, 9, Colors.purple),
                    makeGroupData(5, 4, Colors.yellow),
                    makeGroupData(6, 6, Colors.indigo),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCard(title: 'Nombre de courses', value: '150'),
                CustomCard(title: 'Montant perçu', value: '\$5000'),
                CustomCard(title: 'Commission payée', value: '\$250'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y, Color barColor) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String value;

  const CustomCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(value),
        ],
      ),
    );
  }
}
