import 'package:flutter/material.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  final Color primary = const Color(0xFF1A73E8);
  final Color background = const Color(0xFFF2F5FA);
  final int dailyKcalGoal = 1800;

  final Map<String, List<Map<String, String>>> mealsByCategory = {
    "Breakfast": [
      {"name": "Oatmeal", "kcal": "200"},
    ],
    "Lunch": [
      {"name": "Grilled Chicken", "kcal": "350"},
      {"name": "Brown Rice", "kcal": "215"},
    ],
    "Dinner": [
      {"name": "Caesar Salad", "kcal": "150"},
    ],
  };

  String _getEmoji(String cat) {
    return switch (cat) {
      "Breakfast" => "☀️",
      "Lunch" => "🍽️",
      "Dinner" => "🌙",
      _ => "🍴"
    };
  }

  void _showMealDialog({String? category, int? index}) {
    final isEditing = category != null && index != null;
    final meal = isEditing ? mealsByCategory[category]![index] : null;
    final nameCtrl = TextEditingController(text: meal?["name"]);
    final kcalCtrl = TextEditingController(text: meal?["kcal"]);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isEditing ? "Edit Meal" : "Add Meal"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Meal name"),
            ),
            TextField(
              controller: kcalCtrl,
              decoration: const InputDecoration(labelText: "Calories (kcal)"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isEmpty || kcalCtrl.text.isEmpty) return;
              final mealData = {
                "name": nameCtrl.text,
                "kcal": kcalCtrl.text
              };
              setState(() {
                if (isEditing) {
                  mealsByCategory[category!]![index!] = mealData;
                } else {
                  mealsByCategory[category!]!.add(mealData);
                }
              });
              Navigator.pop(context);
            },
            child: Text(isEditing ? "Save" : "Add"),
          )
        ],
      ),
    );
  }

  int getTotalKcal() {
    return mealsByCategory.values
        .expand((list) => list)
        .fold(0, (sum, m) => sum + int.tryParse(m["kcal"] ?? "0")!);
  }

  @override
  Widget build(BuildContext context) {
    final totalKcal = getTotalKcal();
    final progress = (totalKcal / dailyKcalGoal).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text("Nutrition Tracker"),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 0,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 🍽️ Progress Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary.withOpacity(0.85), primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 6))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Daily Calorie Intake",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 14,
                        borderRadius: BorderRadius.circular(12),
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "$totalKcal/$dailyKcalGoal kcal",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // 🥗 Meals Section
          ...mealsByCategory.entries.map((entry) {
            final cat = entry.key;
            final meals = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("${_getEmoji(cat)} $cat",
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline,
                          color: primary, size: 24),
                      onPressed: () => _showMealDialog(category: cat),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...List.generate(meals.length, (i) {
                  final m = meals[i];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      onTap: () =>
                          _showMealDialog(category: cat, index: i),
                      leading: CircleAvatar(
                        backgroundColor: primary.withOpacity(0.1),
                        child: const Icon(Icons.restaurant_menu,
                            color: Colors.blue),
                      ),
                      title: Text(
                        m["name"]!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        "${m["kcal"]} kcal",
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 15),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
              ],
            );
          }),

          // 🧮 Total Summary
          Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 5,
            color: primary,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Calories",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  Text("$totalKcal kcal",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
