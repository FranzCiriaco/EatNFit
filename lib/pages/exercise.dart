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
    final titleController =
        TextEditingController(text: exercise?['title'] ?? '');
    final durationController =
        TextEditingController(text: exercise?['duration'] ?? '');
    final calorieController =
        TextEditingController(text: exercise?['calories']?.toString() ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isEditing)
                  TextButton(
                    onPressed: () {
                      setState(() => exercises.removeAt(index!));
                      Navigator.pop(context);
                    },
                    child: const Text("Delete",
                        style: TextStyle(color: Colors.red)),
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
                    final calories =
                        int.tryParse(calorieController.text.trim()) ?? 0;

                    if (title.isNotEmpty &&
                        duration.isNotEmpty &&
                        calories > 0) {
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
    final totalCalories =
        exercises.fold(0, (sum, e) => sum + (e['calories'] as int));
    final progress = (totalCalories / goalCalories).clamp(0.0, 1.0);

    final now = DateTime.now();
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final today = "${days[now.weekday - 1]}, ${now.month}/${now.day}";

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FC),
      appBar: AppBar(
        title: const Text("Exercise Tracker"),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showExerciseDialog(),
        backgroundColor: Colors.blue.shade600,
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔥 Motivational Quote
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD54F), Color(0xFFFFF8E1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.shade100,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.format_quote, color: Colors.orange),
                  const SizedBox(width: 10),
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
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 20),

            // 🔵 Progress Ring
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 16,
                        spreadRadius: 4,
                      )
                    ],
                  ),
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 14,
                    backgroundColor: Colors.grey.shade200,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "$totalCalories kcal",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Text("burned"),
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
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: ListTile(
                      onTap: () =>
                          _showExerciseDialog(exercise: ex, index: i),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(ex['icon'], color: Colors.blue.shade700),
                      ),
                      title: Text("${ex['title']} (${ex['duration']})"),
                      trailing: Text("${ex['calories']} kcal"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // 🎯 Goal Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Daily Calorie Goal",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text("$goalCalories kcal",
                      style: TextStyle(color: Colors.blue.shade700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}






