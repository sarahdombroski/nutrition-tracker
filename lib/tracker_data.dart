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

Future<File> writeToFile(Map<String, int> data) async {
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