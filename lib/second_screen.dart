import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Foods"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Text("Food Title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      FloatingActionButton(
                      onPressed: () {
                        // Handle button press
                      },
                      tooltip: 'Add Food',
                      mini: true,
                      child: const Icon(Icons.add, color: Colors.black),
                    )])
                  ]), 
                const Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.start, 
                children: [
                  Expanded(
                    flex: 1,
                    child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [ 
                    Text('Calories: 275'),
                    Text('Protein: 20'),
                    ]),),
                    Expanded(
                      flex: 1,
                      child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [ 
                    Text('Carbs: 15'),
                    Text('Fat: 10'),
                    ])),
                    ])
          ])),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Goes back to first screen
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
