import 'package:flutter/material.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  final Color primaryBlue = const Color(0xFF1A73E8);

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

  String _getCategoryEmoji(String category) {
    switch (category) {
      case "Breakfast":
        return "☀️";
      case "Lunch":
        return "🍽️";
      case "Dinner":
        return "🌙";
      default:
        return "🍴";
    }
  }

  void _addMealDialog(String category) {
    final nameController = TextEditingController();
    final kcalController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Meal"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Meal name"),
            ),
            TextField(
              controller: kcalController,
              decoration: const InputDecoration(labelText: "Calories (kcal)"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  kcalController.text.isNotEmpty) {
                setState(() {
                  mealsByCategory[category]?.add({
                    "name": nameController.text,
                    "kcal": kcalController.text,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _editMealDialog(String category, int index) {
    final meal = mealsByCategory[category]![index];
    final nameController = TextEditingController(text: meal["name"]);
    final kcalController = TextEditingController(text: meal["kcal"]);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Meal"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Meal name"),
            ),
            TextField(
              controller: kcalController,
              decoration: const InputDecoration(labelText: "Calories (kcal)"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  kcalController.text.isNotEmpty) {
                setState(() {
                  mealsByCategory[category]![index] = {
                    "name": nameController.text,
                    "kcal": kcalController.text,
                  };
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  int getTotalKcal() {
    int total = 0;
    for (var category in mealsByCategory.values) {
      for (var meal in category) {
        total += int.tryParse(meal["kcal"]!) ?? 0;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FC),
      appBar: AppBar(
        title: const Text("Meals"),
        centerTitle: true,
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ...mealsByCategory.entries.map((entry) {
            final category = entry.key;
            final meals = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${_getCategoryEmoji(category)} $category",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline,
                          color: primaryBlue, size: 26),
                      onPressed: () => _addMealDialog(category),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ...List.generate(meals.length, (index) {
                  final meal = meals[index];
                  return Dismissible(
                    key: Key('$category-$index-${meal["name"]}'),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      color: Colors.redAccent,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      color: Colors.orange,
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        _editMealDialog(category, index);
                        return false;
                      } else if (direction == DismissDirection.startToEnd) {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Delete Meal"),
                            content: Text(
                                "Are you sure you want to delete '${meal["name"]}' from $category?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Delete",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          setState(() => meals.removeAt(index));
                          return true;
                        }
                        return false;
                      }
                      return false;
                    },
                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.blueAccent.withOpacity(0.1),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: const Icon(Icons.restaurant_menu_rounded,
                            color: Color(0xFF1A73E8)),
                        title: Text(
                          meal["name"]!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        trailing: Text(
                          "${meal["kcal"]} kcal",
                          style:
                              const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
              ],
            );
          }),
          const SizedBox(height: 12),
          Card(
            color: primaryBlue,
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Calories",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${getTotalKcal()} kcal",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}




