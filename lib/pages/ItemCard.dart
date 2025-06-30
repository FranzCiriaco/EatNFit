import 'package:flutter/material.dart';
import 'workoutfood.dart';

class ItemCard extends StatelessWidget {
  final WorkoutFood workoutFood;

  const ItemCard({super.key, required this.workoutFood});

  IconData _getExerciseIcon(String exercise) {
    switch (exercise.toLowerCase()) {
      case 'cycling':
        return Icons.directions_bike;
      case 'running':
        return Icons.directions_run;
      case 'basketball':
        return Icons.sports_basketball;
      case 'jogging':
        return Icons.directions_walk;
      default:
        return Icons.fitness_center;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Colors.blue.shade700; // Fitness blue
    final Color accent = Colors.lightBlueAccent.shade100;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 8,
      shadowColor: primary.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // 🎨 Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              height: 150,
            ),

            // 🌊 Decorative design (e.g. abstract curved overlay)
            Positioned(
              bottom: -30,
              right: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // 💪 Main content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Exercise Icon
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: primary.withOpacity(0.1),
                    child: Icon(
                      _getExerciseIcon(workoutFood.exercise),
                      color: primary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Workout details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workoutFood.exercise.toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primary,
                                letterSpacing: 1.0,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.timer, size: 18, color: Colors.grey[700]),
                            const SizedBox(width: 6),
                            Text(
                              '${workoutFood.minutes} minutes',
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.local_dining, size: 18, color: Colors.grey[700]),
                            const SizedBox(width: 6),
                            Text(
                              workoutFood.food,
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
