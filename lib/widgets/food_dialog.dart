import 'package:flutter/material.dart';

class FoodDialog extends StatelessWidget {
  final void Function(int calories, int protein, int carbs, int fats) onSubmit;

  const FoodDialog({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController caloriesController = TextEditingController();
    final TextEditingController proteinController = TextEditingController();
    final TextEditingController carbsController = TextEditingController();
    final TextEditingController fatsController = TextEditingController();

    return AlertDialog(
      title: Text('Add Food'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter calories"),
            ),
            TextField(
              controller: proteinController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter protein (g)"),
            ),
            TextField(
              controller: carbsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter carbs (g)"),
            ),
            TextField(
              controller: fatsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter fats (g)"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: () {
            final calories = int.tryParse(caloriesController.text.trim()) ?? 0;
            final protein = int.tryParse(proteinController.text.trim()) ?? 0;
            final carbs = int.tryParse(carbsController.text.trim()) ?? 0;
            final fats = int.tryParse(fatsController.text.trim()) ?? 0;

            onSubmit(calories, protein, carbs, fats);
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
