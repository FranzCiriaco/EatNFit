import 'package:flutter/material.dart';
import 'package:my_franz/pages/ItemCard.dart';
import 'package:my_franz/pages/workoutfood.dart';

class ListItems extends StatefulWidget {
  const ListItems({super.key});

  @override
  State<ListItems> createState() => _ListItemsState();
}

List<WorkoutFood> workoutfoods = [
  WorkoutFood(exercise: 'cycling', minutes: 60, food: 'Brown Rice'),
  WorkoutFood(exercise: 'running', minutes: 30, food: 'Salad'),
  WorkoutFood(exercise: 'basketball', minutes: 120, food: 'Meat'),
  WorkoutFood(exercise: 'jogging', minutes: 60, food: 'Egg Sandwich'),
];

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Colors.blue.shade50;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade700,
        title: const Text(
          '🏋️‍♂️ EatNFit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: workoutfoods.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return ItemCard(workoutFood: workoutfoods[index]);
          },
        ),
      ),
    );
  }
}