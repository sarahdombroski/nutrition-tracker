import 'package:flutter/material.dart';
import 'widgets/food_dialog.dart';
import 'widgets/water_dialog.dart';
import 'widgets/goals_dialog.dart';
import 'dictionary_page.dart';
import 'calendar.dart';
import 'data.dart' as globals;


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    globals.loadData().then((data) {
      setState(() {
        globals.updateData(data);
      });
    });
  }

  void _addWater() {
    showDialog(
      context: context,
      builder: (context) => WaterDialog(
        onSubmit: (waterAmount) {
          setState(() {
            globals.water += waterAmount;
            globals.saveData();
          });
        },
      ),
    );
  }

  void _updateNutrients() {
    showDialog(
      context: context,
      builder: (context) => FoodDialog(
        onSubmit: (cal, pro, carb, fat) {
          setState(() {
            globals.protein += pro;
            globals.calories += cal;
            globals.carbs += carb;
            globals.fats += fat;
            globals.saveData();
          });
        },
      ),
    );
  }

  void _editGoals() {
    showDialog(
      context: context,
      builder: (context) => EditGoalsDialog(
        goalCalories: globals.goalCalories,
        goalProtein: globals.goalProtein,
        goalCarbs: globals.goalCarbs,
        goalFats: globals.goalFats,
        goalWater: globals.goalWater,
        onSubmit:
            ({
              required int calories,
              required int protein,
              required int carbs,
              required int fats,
              required int water,
            }) {
              setState(() {
                globals.goalCalories = calories;
                globals.goalProtein = protein;
                globals.goalCarbs = carbs;
                globals.goalFats = fats;
                globals.goalWater = water;
                globals.saveData();
              });
            },
      ),
    );
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
              '${globals.water} / ${globals.goalWater}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            //   child: LinearProgressIndicator(
            //     value: globals.water / globals.goalWater,
            //     color: Colors.blue,
            //     backgroundColor: Colors.blue[100],
            //     minHeight: 7,
            // )),
            Divider(height: 20, thickness: 1, indent: 100, endIndent: 100),

            Text('Calories', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              '${globals.calories} / ${globals.goalCalories}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            //   child: LinearProgressIndicator(
            //     value: globals.calories / globals.goalCalories,
            //     color: Colors.greenAccent,
            //     backgroundColor: Colors.greenAccent[100],
            //     minHeight: 7,
            // )),
            Divider(height: 20, thickness: 1, indent: 100, endIndent: 100),

            Text('Protein', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              '${globals.protein} / ${globals.goalProtein}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            //   child: LinearProgressIndicator(
            //     value: globals.protein / globals.goalProtein,
            //     color: Colors.deepPurple,
            //     backgroundColor: Colors.deepPurple[100],
            //     minHeight: 7,
            // )),
            Divider(height: 20, thickness: 1, indent: 100, endIndent: 100),

            Text('Carbs', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              '${globals.carbs} / ${globals.goalCarbs}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            //   child: LinearProgressIndicator(
            //     value: globals.carbs / globals.goalCarbs,
            //     color: Colors.orange,
            //     backgroundColor: Colors.orange[100],
            //     minHeight: 7,
            // )),
            Divider(height: 20, thickness: 1, indent: 100, endIndent: 100),

            Text('Fats', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              '${globals.fats} / ${globals.goalFats}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            //   child: LinearProgressIndicator(
            //     value: globals.fats / globals.goalFats,
            //     color: Colors.redAccent,
            //     backgroundColor: Colors.redAccent[100],
            //     minHeight: 7,
            // )),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
              onPressed: _updateNutrients,
              tooltip: 'Add Food',
              backgroundColor: Colors.green,
              child: const Icon(Icons.restaurant, color: Colors.white),
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DictionaryPage()),
                );

                if (updated == true) {
                  setState(() {});
                }
              },
              tooltip: 'View Saved Foods',
              backgroundColor: Colors.orange,
              child: const Icon(Icons.library_books, color: Colors.white),
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarScreen()),
                );
              },
              tooltip: 'View Calendar',
              backgroundColor: Colors.purple,
              child: const Icon(Icons.calendar_month, color: Colors.white),
            ),
          ],
        ),
      ))
    );
  }
}
