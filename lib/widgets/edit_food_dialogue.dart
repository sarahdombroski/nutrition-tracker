import 'package:flutter/material.dart';

class EditFoodDialog extends StatelessWidget {
  final String previousName;
  final int previousCalories;
  final int previousProtein;
  final int previousCarbs;
  final int previousFats;
  final void Function(String name, int calories, int protein, int carbs, int fat) onSubmit;

  const EditFoodDialog({
    super.key, 
    required this.previousName,
    required this.previousCalories,
    required this.previousProtein,
    required this.previousCarbs,
    required this.previousFats,
    required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: previousName);
    final TextEditingController caloriesController = TextEditingController(text: previousCalories.toString());
    final TextEditingController proteinController = TextEditingController(text: previousProtein.toString());
    final TextEditingController carbsController = TextEditingController(text: previousCarbs.toString());
    final TextEditingController fatController = TextEditingController(text: previousFats.toString());

    return AlertDialog(
      title: Text('Edit Existing Food'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "Enter food name"),
            ),
            Text("Name"),
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
              controller: fatController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter fat (g)"),
            ),
            Text("Fat (g)"),
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
            final calories = int.tryParse(caloriesController.text.trim()) ?? previousCalories;
            final protein = int.tryParse(proteinController.text.trim()) ?? previousProtein;
            final carbs = int.tryParse(carbsController.text.trim()) ?? previousCarbs;
            final fat = int.tryParse(fatController.text.trim()) ?? previousFats;

            onSubmit(name, calories, protein, carbs, fat);
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
