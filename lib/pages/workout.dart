import 'package:flutter/material.dart';

class Workout extends StatefulWidget {
  const Workout({super.key});

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  // Controllers to handle input fields
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _exerciseController.dispose();
    _foodController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Workout Tracker'),
        backgroundColor: Colors.blue[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Attach the form key here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Exercise, Food & Weight',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Exercise input
              _buildInputField(
                controller: _exerciseController,
                label: 'Enter exercise name',
                icon: Icons.fitness_center,
                iconColor: Colors.blue,
                validatorMessage: 'Please enter an exercise name',
              ),

              const SizedBox(height: 20),

              // Food input
              _buildInputField(
                controller: _foodController,
                label: 'Enter food for the day',
                icon: Icons.fastfood,
                iconColor: Colors.orange,
                validatorMessage: 'Please enter food for the day',
              ),

              const SizedBox(height: 20),

              // Weight input
              _buildInputField(
                controller: _weightController,
                label: 'Enter weight (kg)',
                icon: Icons.accessibility,
                iconColor: Colors.green,
                isNumber: true,
                customValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter weight';
                  }
                  final weight = double.tryParse(value);
                  if (weight == null || weight <= 0) {
                    return 'Please enter a valid weight greater than 0';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              // Submit button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Exercise, Food & Weight Added')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Add Entry',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color iconColor,
    String? validatorMessage,
    bool isNumber = false,
    String? Function(String?)? customValidator,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: iconColor),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        validator: customValidator ??
            (value) {
              if (value == null || value.isEmpty) {
                return validatorMessage ?? 'Please fill this field';
              }
              return null;
            },
      ),
    );
  }
}


