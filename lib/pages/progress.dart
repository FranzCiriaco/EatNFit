import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progress")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text("Weight Progress", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 100, child: Placeholder()), // Replace with a chart
            Divider(),
            ListTile(title: Text("Calories"), trailing: Text("📊")),
            ListTile(title: Text("Steps"), trailing: Text("📈")),
            ListTile(title: Text("Goal"), trailing: Text("Lose weight")),
          ],
        ),
      ),
    );
  }
}
