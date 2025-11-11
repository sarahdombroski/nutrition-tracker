import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
export 'tracker_data.dart';

Future<String> get _localPath async {
  final directory = await getApplicationSupportDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/saveData.json');
}

Future<File> writeToFile(Map<String, Map<String, dynamic>> data) async {
  final file = await _localFile;
  return file.writeAsString(jsonEncode(data));
}

Future<File> get localFile async => _localFile;
Future<String> get localPath async => _localPath;

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
  FoodData? foodData;

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
      foodData: json['foodData'] != null
          ? FoodData.fromJson(json['foodData'])
          : null,
    );
  }

  // Convert object to JSON map for saving
  Map<String, dynamic> toJson() {
    return {
      'nutritionData': nutritionData.toJson(),
      'goalsData': goalsData.toJson(),
      'foodData': foodData?.toJson(),
    };
  }
}