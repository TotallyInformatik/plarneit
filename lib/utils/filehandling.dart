import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plarneit/utils/constants.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get localFile async {
  final path = await localPath;
  return File("$path/$JSON_FILE_NAME");
}

Future<Map> readFile() async {
  final file = await localFile;
  final fileExists = file.exists();
  if (await fileExists) {
    return jsonDecode(file.readAsStringSync());
  }
}

Future<void> writeToJson(Map jsonContent) async {
  final file = await localFile;
  final fileExists = file.exists();
  if (await fileExists) {
    file.writeAsStringSync(jsonEncode(jsonContent));
  }
}