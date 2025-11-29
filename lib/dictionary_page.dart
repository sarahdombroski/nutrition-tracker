import 'package:flutter/material.dart';
import 'data.dart' as globals;
import 'widgets/create_food_dialog.dart';
import 'widgets/edit_food_dialogue.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {

  List<Map<String, dynamic>> food = globals.food;

  void _addToList() {
    showDialog(
      context: context,
      builder: (context) => CreateFoodDialog(
        onSubmit: (name, calories, protein, carbs, fat) {
          setState(() {
            globals.addFood({
              'name': name,
              'calories': calories,
              'protein': protein,
              'carbs': carbs,
              'fat': fat,
            });
            globals.saveData();
          });
        },
      ),
    );
  }

  void _deleteFood(int index) {
    setState(() {
      globals.removeFood(index);
      globals.saveData();
    });
  }

  void _updateNutrients(int pro, int cal, int carb, int fat) {
    setState(() {
      globals.protein += pro;
      globals.calories += cal;
      globals.carbs += carb;
      globals.fats += fat;
      globals.saveData();
    });
    Navigator.pop(context, true);
  }

  void _editFood(int index) {
    final editingFood = food[index];
    showDialog(
      context: context, 
      builder: (context) => EditFoodDialog(previousName: editingFood['name'], previousCalories: editingFood['calories'], previousProtein: editingFood['protein'], previousCarbs: editingFood['carbs'], previousFats: editingFood['fat'], 
      onSubmit: (newName, newCal, newPro, newCarb, newFat) {
        setState(() {
          editingFood['name'] = newName;
          editingFood['calories'] = newCal;
          editingFood['protein'] = newPro;
          editingFood['carbs'] = newCarb;
          editingFood['fat'] = newFat;

          globals.saveData();
        });
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Foods"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: food.length,
              itemBuilder: (context, index) {
                final item = food[index];

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${item['name']!}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  _deleteFood(index);
                                },
                                tooltip: 'Delete from List',
                                mini: true,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              FloatingActionButton(
                                onPressed: () {
                                  _editFood(index);
                                },
                                tooltip: 'Edit Food',
                                mini: true,
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              FloatingActionButton(
                                onPressed: () {
                                  _updateNutrients(item['protein'], item['calories'], item['carbs'], item['fat']);
                                },
                                tooltip: 'Add Food',
                                mini: true,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Calories: ${item['calories']}'),
                                Text('Protein: ${item['protein']}'),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Carbs: ${item['carbs']}'),
                                Text('Fat: ${item['fat']}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToList,
        tooltip: 'Add Food to List',
        backgroundColor: Colors.green,
        child: const Icon(Icons.list_alt, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
