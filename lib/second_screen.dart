import 'package:flutter/material.dart';

final food = [
  {'name': 'Macaroni', 'calories': 275, 'protein': 20, 'carbs': 40, 'fat': 23},
  {'name': 'Potato', 'calories': 250, 'protein': 10, 'carbs': 50, 'fat': 16},
  {'name': 'Pancake', 'calories': 200, 'protein': 4, 'carbs': 42, 'fat': 10},
];

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  void _addToList() {}

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
                                  // Handle button press
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
                                  // Handle button press
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
                                  // Handle button press
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
