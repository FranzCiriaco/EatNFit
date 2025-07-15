import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String kcalSub = "of 2,000 kcal target";
  String stepsSub = "5,000 of 10,000";
  String waterSub = "4 of 9 cups";
  int _selectedIndex = 0;

  final Color primaryBlue = const Color(0xFF1A73E8);

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushNamed(context, '/progress');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FC),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Good morning, Franz 👋",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Here’s your wellness summary for today.",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 28),

                      /// Health Cards
                      buildCard(
                        context,
                        icon: "🍏",
                        title: "1,250 kcal left",
                        subtitle: kcalSub,
                        onUpdateSubtitle: (newSub) =>
                            setState(() => kcalSub = newSub),
                      ),
                      const SizedBox(height: 16),
                      buildCard(
                        context,
                        icon: "👣",
                        title: "Steps Today",
                        subtitle: stepsSub,
                        onUpdateSubtitle: (newSub) =>
                            setState(() => stepsSub = newSub),
                      ),
                      const SizedBox(height: 16),
                      buildCard(
                        context,
                        icon: "💧",
                        title: "Water Intake",
                        subtitle: waterSub,
                        onUpdateSubtitle: (newSub) =>
                            setState(() => waterSub = newSub),
                      ),

                      const SizedBox(height: 32),
                      const Divider(thickness: 1.2, color: Colors.grey),
                      const SizedBox(height: 24),

                      /// Action Buttons
                      buildPrimaryButton(
                        icon: Icons.restaurant_menu_rounded,
                        label: "Add Food",
                        onPressed: () => Navigator.pushNamed(context, '/meals'),
                      ),
                      const SizedBox(height: 14),
                      buildPrimaryButton(
                        icon: Icons.fitness_center_rounded,
                        label: "Add Exercise",
                        onPressed: () =>
                            Navigator.pushNamed(context, '/exercise'),
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        backgroundColor: Colors.white,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.grey,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_rounded),
            label: "Progress",
          ),
        ],
      ),
    );
  }

  Widget buildCard(
    BuildContext context, {
    required String icon,
    required String title,
    required String subtitle,
    required Function(String) onUpdateSubtitle,
  }) {
    return GestureDetector(
      onTap: () => _showEditDialog(context, title, subtitle, onUpdateSubtitle),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.blueAccent.withOpacity(0.1),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          child: Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 36)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54)),
                  ],
                ),
              ),
              const Icon(Icons.edit, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPrimaryButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 22),
        label: Text(label, style: const TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 4,
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String title,
    String subtitle,
    Function(String) onUpdateSubtitle,
  ) {
    final subtitleController = TextEditingController(text: subtitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Info"),
          content: TextField(
            controller: subtitleController,
            decoration: const InputDecoration(labelText: "Subtitle"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onUpdateSubtitle(subtitleController.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}






