import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrition Tracker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4CAF50)),
      ),
      home: const MyHomePage(title: 'Nutrition Tracker'),
    );
  }
}
class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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

  void _addWater() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Water'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter water (oz)"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                final text = controller.text.trim();
                if (text.isNotEmpty) {
                  final parsed = int.tryParse(text);
                  if (parsed != null) {
                    setState(() {
                      _water += parsed;
                    });
                  }
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addFood() {
    final TextEditingController caloriesController = TextEditingController();
    final TextEditingController proteinController = TextEditingController();
    final TextEditingController carbsController = TextEditingController();
    final TextEditingController fatsController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                final caloriesText = caloriesController.text.trim();
                final proteinText = proteinController.text.trim();
                final carbsText = carbsController.text.trim();
                final fatsText = fatsController.text.trim();
                
                final calories = int.tryParse(caloriesText) ?? 0;
                final protein = int.tryParse(proteinText) ?? 0;
                final carbs = int.tryParse(carbsText) ?? 0;
                final fats = int.tryParse(fatsText) ?? 0;
                
                setState(() {
                  _calories += calories;
                  _protein += protein;
                  _carbs += carbs;
                  _fats += fats;
                });
                
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editGoals() {
    final TextEditingController caloriesController = TextEditingController(text: _goalCalories.toString());
    final TextEditingController proteinController = TextEditingController(text: _goalProtein.toString());
    final TextEditingController carbsController = TextEditingController(text: _goalCarbs.toString());
    final TextEditingController fatsController = TextEditingController(text: _goalFats.toString());
    final TextEditingController waterController = TextEditingController(text: _goalWater.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Goals'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Goal Calories:"),
                TextField(
                  controller: caloriesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Goal calories"),
                ),
                Text("Goal Protein (g):"),
                TextField(
                  controller: proteinController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Goal protein (g)"),
                ),
                Text("Goal Carbs (g):"),
                TextField(
                  controller: carbsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Goal carbs (g)"),
                ),
                Text("Goal Fats (g):"),
                TextField(
                  controller: fatsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Goal fats (g)"),
                ),
                Text("Goal Water (oz):"),
                TextField(
                  controller: waterController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Goal water (oz)"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                final caloriesText = caloriesController.text.trim();
                final proteinText = proteinController.text.trim();
                final carbsText = carbsController.text.trim();
                final fatsText = fatsController.text.trim();
                final waterText = waterController.text.trim();
                
                final calories = int.tryParse(caloriesText) ?? 0;
                final protein = int.tryParse(proteinText) ?? 0;
                final carbs = int.tryParse(carbsText) ?? 0;
                final fats = int.tryParse(fatsText) ?? 0;
                final water = int.tryParse(waterText) ?? 0;
                
                setState(() {
                  if (caloriesText.isNotEmpty) _goalCalories = calories;
                  if (proteinText.isNotEmpty) _goalProtein = protein;
                  if (carbsText.isNotEmpty) _goalCarbs = carbs;
                  if (fatsText.isNotEmpty) _goalFats = fats;
                  if (waterText.isNotEmpty) _goalWater = water;
                });
                
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Water', style: Theme.of(context).textTheme.headlineMedium),
            Text('$_water / $_goalWater', style: Theme.of(context).textTheme.headlineSmall),
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
            Text('$_carbs / $_goalCarbs', style: Theme.of(context).textTheme.headlineSmall),
            Divider(height: 20, thickness: 1, indent: 100, endIndent: 100),

            Text('Fats', style: Theme.of(context).textTheme.headlineMedium),
            Text('$_fats / $_goalFats', style: Theme.of(context).textTheme.headlineSmall),
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
        ],
      ),
    );
  }
}
