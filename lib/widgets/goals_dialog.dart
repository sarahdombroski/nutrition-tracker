import 'package:flutter/material.dart';

class EditGoalsDialog extends StatelessWidget {
  final int goalCalories;
  final int goalProtein;
  final int goalCarbs;
  final int goalFats;
  final int goalWater;
  final void Function({
    required int calories,
    required int protein,
    required int carbs,
    required int fats,
    required int water,
  })
  onSubmit;

  const EditGoalsDialog({
    super.key,
    required this.goalCalories,
    required this.goalProtein,
    required this.goalCarbs,
    required this.goalFats,
    required this.goalWater,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final caloriesController = TextEditingController(
      text: goalCalories.toString(),
    );
    final proteinController = TextEditingController(
      text: goalProtein.toString(),
    );
    final carbsController = TextEditingController(text: goalCarbs.toString());
    final fatsController = TextEditingController(text: goalFats.toString());
    final waterController = TextEditingController(text: goalWater.toString());

    return AlertDialog(
      title: const Text('Edit Goals'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [          
            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter calories"),
            ),
            Text("Calories"),
            TextField(
              controller: proteinController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter protein (g)"),
            ),
            Text("Protein (g)"),
            TextField(
              controller: carbsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter carbs (g)"),
            ),
            Text("Carbs (g)"),
            TextField(
              controller: fatsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter fat (g)"),
            ),
            Text("Fat (g)"),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            final calories = int.tryParse(caloriesController.text.trim()) ?? 0;
            final protein = int.tryParse(proteinController.text.trim()) ?? 0;
            final carbs = int.tryParse(carbsController.text.trim()) ?? 0;
            final fats = int.tryParse(fatsController.text.trim()) ?? 0;
            final water = int.tryParse(waterController.text.trim()) ?? 0;

            onSubmit(
              calories: calories,
              protein: protein,
              carbs: carbs,
              fats: fats,
              water: water,
            );

            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
