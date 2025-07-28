import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<Map<String, dynamic>> exercises = [
    {
      'title': 'Running',
      'duration': '30 min',
      'calories': 250,
      'icon': Icons.directions_run,
    },
    {
      'title': 'Cycling',
      'duration': '20 min',
      'calories': 180,
      'icon': Icons.directions_bike,
    },
  ];

  final int goalCalories = 500;

  final List<String> quotes = [
    "Push yourself, no one else will.",
    "Success starts with self-discipline.",
    "You are stronger than you think.",
    "It never gets easier, you get better.",
    "Your mind gives up before your body.",
    "Challenge your limits!",
  ];

  late String dailyQuote;

  @override
  void initState() {
    super.initState();
    final daySeed = DateTime.now().day;
    dailyQuote = quotes[daySeed % quotes.length];
  }

  void _showExerciseDialog({Map<String, dynamic>? exercise, int? index}) {
    final isEditing = exercise != null;
    final titleController = TextEditingController(text: exercise?['title'] ?? '');
    final durationController = TextEditingController(text: exercise?['duration'] ?? '');
    final calorieController = TextEditingController(text: exercise?['calories']?.toString() ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 24,
          left: 24,
          right: 24,
        ),
        child: Wrap(
          children: [
            Center(
              child: Text(
                isEditing ? 'Edit Exercise' : 'Add Exercise',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Exercise Name'),
            ),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(labelText: 'Duration'),
            ),
            TextField(
              controller: calorieController,
              decoration: const InputDecoration(labelText: 'Calories Burned'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isEditing)
                  TextButton(
                    onPressed: () {
                      setState(() => exercises.removeAt(index!));
                      Navigator.pop(context);
                    },
                    child: const Text("Delete", style: TextStyle(color: Colors.red)),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    final duration = durationController.text.trim();
                    final calories = int.tryParse(calorieController.text.trim()) ?? 0;

                    if (title.isNotEmpty && duration.isNotEmpty && calories > 0) {
                      final newExercise = {
                        'title': title,
                        'duration': duration,
                        'calories': calories,
                        'icon': Icons.fitness_center,
                      };

                      setState(() {
                        if (isEditing) {
                          exercises[index!] = newExercise;
                        } else {
                          exercises.add(newExercise);
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text(isEditing ? "Save" : "Add"),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalCalories = exercises.fold(0, (sum, e) => sum + (e['calories'] as int));
    final progress = (totalCalories / goalCalories).clamp(0.0, 1.0);

    final now = DateTime.now();
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final today = "${days[now.weekday - 1]}, ${now.month}/${now.day}";

    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FB),
      appBar: AppBar(
        title: const Text("Exercise Tracker"),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showExerciseDialog(),
        icon: const Icon(Icons.add),
        label: const Text("Add Exercise"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // 🔥 Motivation
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD54F), Color(0xFFFFF9C4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.shade100,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.format_quote_rounded, color: Colors.orange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      dailyQuote,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 📅 Date
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Today • $today",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ⭕ Circular Progress Ring
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 16,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "$totalCalories kcal",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text("burned today"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 📝 Exercise List
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (_, i) {
                  final ex = exercises[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: ListTile(
                      onTap: () => _showExerciseDialog(exercise: ex, index: i),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade50,
                        child: Icon(ex['icon'], color: Colors.blue.shade600),
                      ),
                      title: Text(
                        ex['title'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(ex['duration']),
                      trailing: Text(
                        "${ex['calories']} kcal",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // 🎯 Goal Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Daily Goal",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "$goalCalories kcal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
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
