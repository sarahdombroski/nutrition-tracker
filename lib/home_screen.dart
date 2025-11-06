import 'package:flutter/material.dart';
import 'widgets/food_dialog.dart';
import 'widgets/water_dialog.dart';
import 'widgets/goals_dialog.dart';
import 'second_screen.dart';
import 'tracker_data.dart';
import 'dart:convert';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _calories = 0;
  int _protein = 0;
  int _carbs = 0;
  int _fats = 0;
  int _water = 0;

  int _goalCalories = 2000;
  int _goalProtein = 150;
  int _goalCarbs = 250;
  int _goalFats = 70;
  int _goalWater = 64;

  @override
  void initState() {
    super.initState();
    loadNutritionData().then((data) {
      setState(() {
        _calories = data.calories;
        _protein = data.protein;
        _carbs = data.carbs;
        _fats = data.fats;
        _water = data.water;
      });
    });
  }

  Future<NutritionData> loadNutritionData() async {
    final file = await localFile;
    if (await file.exists()) {
      final contents = await file.readAsString();
      final data = jsonDecode(contents);
      return NutritionData.fromJson(data);
    } else {
      // Create a new file with default values
      final defaultData = NutritionData(
        calories: 0,
        carbs: 0,
        fats: 0,
        protein: 0,
        water: 0,
      );
    await file.writeAsString(jsonEncode(defaultData.toJson()));
    return defaultData;
    }
  }

  void _addWater() {
    showDialog(
      context: context,
      builder: (context) => WaterDialog(
        onSubmit: (waterAmount) {
          setState(() {
            _water += waterAmount;
          });
        },
      ),
    );
  }

  void _addFood() {
    showDialog(
      context: context,
      builder: (context) => FoodDialog(
        onSubmit: (cal, pro, carb, fat) {
          setState(() {
            _calories += cal;
            _protein += pro;
            _carbs += carb;
            _fats += fat;
          });
        },
      ),
    );
  }

  void _editGoals() {
    showDialog(
      context: context,
      builder: (context) => EditGoalsDialog(
        goalCalories: _goalCalories,
        goalProtein: _goalProtein,
        goalCarbs: _goalCarbs,
        goalFats: _goalFats,
        goalWater: _goalWater,
        onSubmit:
            ({
              required int calories,
              required int protein,
              required int carbs,
              required int fats,
              required int water,
            }) {
              setState(() {
                _goalCalories = calories;
                _goalProtein = protein;
                _goalCarbs = carbs;
                _goalFats = fats;
                _goalWater = water;
              });
            },
      ),
    );
  }

  void _saveInfo() async {
    final data = {
      'calories': _calories,
      'protein': _protein,
      'fats': _fats,
      'carbs': _carbs,
      'water': _water,
    };

    writeToFile(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Water', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              '$_water / $_goalWater',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Divider(height: 20, thickness: 1, indent: 100, endIndent: 100),

            Text('Calories', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              '$_calories / $_goalCalories',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Divider(height: 20, thickness: 1, indent: 100, endIndent: 100),

            Text('Protein', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              '$_protein / $_goalProtein',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Divider(height: 20, thickness: 1, indent: 100, endIndent: 100),

            Text('Carbs', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              '$_carbs / $_goalCarbs',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Divider(height: 20, thickness: 1, indent: 100, endIndent: 100),

            Text('Fats', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              '$_fats / $_goalFats',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _editGoals,
            tooltip: 'Edit Goals',
            backgroundColor: const Color.fromARGB(255, 202, 115, 112),
            child: const Icon(Icons.edit, color: Colors.white),
          ),
          SizedBox(width: 10), // Add some space between the buttons
          FloatingActionButton(
            onPressed: _addWater,
            tooltip: 'Add Water',
            backgroundColor: Colors.blue,
            child: const Icon(Icons.water_drop, color: Colors.white),
          ),
          SizedBox(width: 10), // Add some space between the buttons
          FloatingActionButton(
            onPressed: _addFood,
            tooltip: 'Add Food',
            backgroundColor: Colors.green,
            child: const Icon(Icons.restaurant, color: Colors.white),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _saveInfo,
            tooltip: 'Save Data',
            backgroundColor: Colors.indigo,
            child: const Icon(Icons.save, color: Colors.white),
          ),

          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondScreen()),
              );
            },
            tooltip: 'View Stats',
            backgroundColor: Colors.orange,
            child: const Icon(Icons.bar_chart, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
