library;

import 'file_utils.dart';
import 'dart:convert';

int calories = 0;
int protein = 0;
int carbs = 0;
int fats = 0;
int water = 0;

int goalCalories = 2000;
int goalProtein = 150;
int goalCarbs = 250;
int goalFats = 70;
int goalWater = 64;

List<Map<String, dynamic>> food = [];

Map<String, Map<String, dynamic>> toJson() {
  final timestamp = DateTime.now();
  return {
    timestamp.toIso8601String(): {
    'nutritionData': {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'water': water,
    },
    'goalsData': {
      'calorieGoal': goalCalories,
      'proteinGoal': goalProtein,
      'carbGoal': goalCarbs,
      'fatGoal': goalFats,
      'waterGoal': goalWater,
    },
    'foodData': {'food': food},
    }
  };
}

void addFood(Map<String, dynamic> newFood) {
  food.add(newFood);
}

void removeFood(int index) {
  food.removeAt(index);
}

void updateData(TrackerData data) {
  calories = data.nutritionData.calories;
  protein = data.nutritionData.protein;
  carbs = data.nutritionData.carbs;
  fats = data.nutritionData.fats;
  water = data.nutritionData.water;

  goalCalories = data.goalsData.calorieGoal;
  goalProtein = data.goalsData.proteinGoal;
  goalCarbs = data.goalsData.carbGoal;
  goalFats = data.goalsData.fatGoal;
  goalWater = data.goalsData.waterGoal;

  food = data.foodData != null && data.foodData!['food'] is List
      ? List<Map<String, dynamic>>.from(data.foodData!['food'])
      : [];
}

void saveData() async {
    final data = toJson();
    await writeToFile(data);
}

Future<TrackerData> loadData() async {
    try {
      final file = await localFile;
      final contents = await file.readAsString();
      final Map<String, dynamic> jsonData = jsonDecode(contents);
      final timestamp = DateTime.now(); // Use a fixed date or current date as needed
      String timestampKey;
      String? matchingKey;
      String? latestKeyStr;
      DateTime? latestKeyDate;

      for (final k in jsonData.keys) {
        final parsed = DateTime.tryParse(k);
        if (parsed == null) continue;
        if (latestKeyDate == null || parsed.isAfter(latestKeyDate)) {
          latestKeyDate = parsed;
          latestKeyStr = k;
        }
        if (parsed.year == timestamp.year &&
            parsed.month == timestamp.month &&
            parsed.day == timestamp.day) {
          matchingKey = k;
          break;
        }
      }

      // Choose timestamp key: prefer exact match, else latest available.
      if (matchingKey != null) {
        timestampKey = matchingKey;
      } else if (latestKeyStr != null) {
        timestampKey = latestKeyStr;
      } else {
        // No timestamps present in file — return default data
        return TrackerData(
          nutritionData: NutritionData(
            calories: 0,
            carbs: 0,
            fats: 0,
            protein: 0,
            water: 0,
          ),
          goalsData: GoalsData(
            calorieGoal: 2000,
            proteinGoal: 150,
            carbGoal: 250,
            fatGoal: 70,
            waterGoal: 64,
          ),
          foodData: null,
        );
      }

      final jsonDataAtTimestamp = jsonData[timestampKey];
      // If the selected timestamp key does not exist or is malformed, return defaults
      if (jsonDataAtTimestamp == null || jsonDataAtTimestamp is! Map<String, dynamic>) {
        return TrackerData(
          nutritionData: NutritionData(
            calories: 0,
            carbs: 0,
            fats: 0,
            protein: 0,
            water: 0,
          ),
          goalsData: GoalsData(
            calorieGoal: 2000,
            proteinGoal: 150,
            carbGoal: 250,
            fatGoal: 70,
            waterGoal: 64,
          ),
          foodData: null,
        );
      }

      final nutritionJson = jsonDataAtTimestamp['nutritionData'] is Map
          ? Map<String, dynamic>.from(jsonDataAtTimestamp['nutritionData'])
          : <String, dynamic>{};
      final goalsJson = jsonDataAtTimestamp['goalsData'] is Map
          ? Map<String, dynamic>.from(jsonDataAtTimestamp['goalsData'])
          : <String, dynamic>{};

      final nutritionData = NutritionData.fromJson(nutritionJson);
      final goalsData = GoalsData.fromJson(goalsJson);
      final foodData = jsonDataAtTimestamp['foodData'];
      return TrackerData(
        nutritionData: nutritionData,
        goalsData: goalsData,
        foodData: foodData,
      );
    } catch (e) {
      // If encountering an error, return default data
      return TrackerData(
        nutritionData: NutritionData(
          calories: 0,
          carbs: 0,
          fats: 0,
          protein: 0,
          water: 0,
        ),
        goalsData: GoalsData(
          calorieGoal: 2000,
          proteinGoal: 150,
          carbGoal: 250,
          fatGoal: 70,
          waterGoal: 64,
        ),
        foodData: null
      );
    }
  }

class NutritionData {
  int calories;
  int carbs;
  int fats;
  int protein;
  int water;

  NutritionData({
    required this.calories,
    required this.carbs,
    required this.fats,
    required this.protein,
    required this.water,
  });

  // Factory constructor to create from JSON map
  factory NutritionData.fromJson(Map<String, dynamic> json) {
    return NutritionData(
      calories: json['calories'] ?? 0,
      carbs: json['carbs'] ?? 0,
      fats: json['fats'] ?? 0,
      protein: json['protein'] ?? 0,
      water: json['water'] ?? 0,
    );
  }

  // Convert object to JSON map for saving
  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'carbs': carbs,
      'fats': fats,
      'protein': protein,
      'water': water,
    };
  }
}

class GoalsData {
  int calorieGoal;
  int carbGoal;
  int fatGoal;
  int proteinGoal;
  int waterGoal;

  GoalsData({
    required this.calorieGoal,
    required this.carbGoal,
    required this.fatGoal,
    required this.proteinGoal,
    required this.waterGoal,
  });

  // Factory constructor to create from JSON map
  factory GoalsData.fromJson(Map<String, dynamic> json) {
    return GoalsData(
      calorieGoal: json['calorieGoal'] ?? 0,
      carbGoal: json['carbGoal'] ?? 0,
      fatGoal: json['fatGoal'] ?? 0,
      proteinGoal: json['proteinGoal'] ?? 0,
      waterGoal: json['waterGoal'] ?? 0,
    );
  }

  // Convert object to JSON map for saving
  Map<String, dynamic> toJson() {
    return {
      'calorieGoal': calorieGoal,
      'carbGoal': carbGoal,
      'fatGoal': fatGoal,
      'proteinGoal': proteinGoal,
      'waterGoal': waterGoal,
    };
  }
}

class FoodData {
  String name;
  int calories;
  int protein;
  int carbs;
  int fat;

  FoodData({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory FoodData.fromJson(Map<String, dynamic> json) {
    return FoodData(
      name: json['name'] ?? '',
      calories: json['calories'] ?? 0,
      protein: json['protein'] ?? 0,
      carbs: json['carbs'] ?? 0,
      fat: json['fat'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }
}

class TrackerData {
  NutritionData nutritionData;
  GoalsData goalsData;
  Map<String, dynamic>? foodData;

  TrackerData({
    required this.nutritionData,
    required this.goalsData,
    this.foodData,
  });

  // Factory constructor to create from JSON map
  factory TrackerData.fromJson(Map<String, dynamic> json) {
    return TrackerData(
      nutritionData: NutritionData.fromJson(json['nutritionData'] ?? {}),
      goalsData: GoalsData.fromJson(json['goalsData'] ?? {}),
      foodData: json['foodData'] ?? {},
    );
  }

  // Convert object to JSON map for saving
  Map<String, dynamic> toJson() {
    final timestamp = DateTime.now();
    return {
      timestamp.toIso8601String(): {
        'nutritionData': nutritionData.toJson(),
        'goalsData': goalsData.toJson(),
        'foodData': foodData ?? {},
      }
    };
  }
}