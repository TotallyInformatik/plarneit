import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

///
/// Classes to keep track of json information
///

class JsonHandlerWidget extends InheritedWidget {

  final JsonHandlerCollection jsonHandlers;
  JsonHandlerWidget({Key key, @required this.jsonHandlers, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(JsonHandlerWidget oldWidget) => jsonHandlers != oldWidget.jsonHandlers;

  static JsonHandlerCollection of(BuildContext context) {
    final JsonHandlerWidget result = context.dependOnInheritedWidgetOfExactType<JsonHandlerWidget>();
    assert(result != null, "No JsonHandlerWidget in context");
    return result.jsonHandlers;
  }
}

class JsonHandlerCollection {

  final JsonHandler noteHandler;
  final JsonHandler taskHandler;
  final JsonHandler longtermGoalsHandler;
  final JsonHandler settingsHandler;

  JsonHandlerCollection(this.noteHandler, this.taskHandler, this.longtermGoalsHandler, this.settingsHandler);

}



class JsonHandler {

  final String fileName;

  JsonHandler(this.fileName, {Map initialMap}) {
    _initializeFile(initialMap: initialMap);
  }

  void _initializeFile({Map initialMap}) async {
    File jsonFile = await this.localFile;
    if (!jsonFile.existsSync()) {
      jsonFile.createSync();
      this.writeToJson({});
      if (initialMap != null) {
        this.writeToJson(initialMap);
      }
    }
  }

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File("$path/${this.fileName}");
  }

  Future<Map<String, dynamic>> readFile() async {
    final file = await localFile;
    final fileExists = await file.exists();
    if (fileExists) {
      return jsonDecode(file.readAsStringSync());
    } else {
      print("file does not exist!!!");
    }
  }

  Future<void> writeToJson(Map jsonContent) async {
    final file = await this.localFile;
    final fileExists = file.exists();
    if (await fileExists) {
      file.writeAsStringSync(jsonEncode(jsonContent));
      print(await readFile());
    } else {
      print("file does not exist!!!");
    }
  }

}