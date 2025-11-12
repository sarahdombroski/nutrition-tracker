import 'package:flutter/material.dart';

class CreateFoodDialog extends StatelessWidget {
  final void Function(String name, int calories, int protein, int carbs, int fat) onSubmit;

  const CreateFoodDialog({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController caloriesController = TextEditingController();
    final TextEditingController proteinController = TextEditingController();
    final TextEditingController carbsController = TextEditingController();
    final TextEditingController fatController = TextEditingController();

    return AlertDialog(
      title: Text('Add Food to List'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "Enter food name"),
            ),
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
              controller: fatController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter fat (g)"),
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
            final name = nameController.text;
            final calories = int.tryParse(caloriesController.text.trim()) ?? 0;
            final protein = int.tryParse(proteinController.text.trim()) ?? 0;
            final carbs = int.tryParse(carbsController.text.trim()) ?? 0;
            final fat = int.tryParse(fatController.text.trim()) ?? 0;

            onSubmit(name, calories, protein, carbs, fat);
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
