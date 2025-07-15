import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exercise")),
      body: Column(
        children: const [
          ListTile(title: Text("Running (30 min)"), trailing: Text("250 kcal")),
          ListTile(title: Text("Cycling (20 min)"), trailing: Text("180 kcal")),
          Divider(),
          ListTile(title: Text("Total Burned"), trailing: Text("410 kcal")),
        ],
      ),
    );
  }
}



