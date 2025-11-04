import 'dart:io';
import 'package:path_provider/path_provider.dart';
export 'save_to_file.dart';
import 'dart:convert';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
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

Future<String> readFromFile() async {
  try {
    final file = await _localFile;
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return 'Error reading file: $e';
  }
}
