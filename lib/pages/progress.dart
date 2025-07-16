import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  final List<double> weeklyCalories = const [300, 450, 200, 500, 400, 350, 600];

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Progress"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Your Weekly Stats",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
            ),
            const SizedBox(height: 20),

            // Chart card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Calories Burned This Week",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 200, child: _BarChart()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: days.map((d) => Text(d)).toList(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Stats Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _StatCard(title: "Steps", value: "8,450", icon: Icons.directions_walk, color: Colors.green),
                _StatCard(title: "Goal", value: "Lose Weight", icon: Icons.flag, color: Colors.orange),
                _StatCard(title: "Weight", value: "68 kg", icon: Icons.monitor_weight, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 20),

            // Date note
            Center(
              child: Text(
                "Today • ${days[today.weekday - 1]}, ${today.month}/${today.day}/${today.year}",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Bar Chart Widget
class _BarChart extends StatelessWidget {
  const _BarChart();

  final List<double> values = const [300, 450, 200, 500, 400, 350, 600];

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        barGroups: values.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: value,
                color: Colors.blue.shade600,
                width: 16,
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          );
        }).toList(),
        titlesData: FlTitlesData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }
}

// Reusable stat card
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}




