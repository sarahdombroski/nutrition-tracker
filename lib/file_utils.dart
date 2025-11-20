import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
export 'file_utils.dart';

Future<String> get _localPath async {
  final directory = await getApplicationSupportDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/saveData.json');
}

Future<void> addEntryForToday(File file, Map<String, Map<String, dynamic>> entry) async {
  String content = await file.readAsString();
  final today = DateTime.now().toIso8601String().split('T')[0];
  Map<String, dynamic> allData = content.isNotEmpty ? jsonDecode(content) : {};
  allData[today] = entry[today];
  await file.writeAsString(jsonEncode(allData));
}

Future<void> writeToFile(Map<String, Map<String, dynamic>> data) async {
  final file = await _localFile;
  await addEntryForToday(file, data);
}

Future<File> get localFile async => _localFile;
Future<String> get localPath async => _localPath;