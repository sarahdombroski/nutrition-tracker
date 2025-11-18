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

Future<File> writeToFile(Map<String, Map<String, dynamic>> data) async {
  final file = await _localFile;
  return file.writeAsString(jsonEncode(data));
}

Future<File> get localFile async => _localFile;
Future<String> get localPath async => _localPath;