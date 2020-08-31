import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

class CliConfig {
  // Em devsevolvimento
  static Future<File> getFileConfig() async {
    String scriptFile = Platform.script.toFilePath();
    String path = join(dirname(scriptFile), '.get_cli.yaml');
    File configFile = File(path);
    if (!await configFile.exists()) {
      await configFile.create(recursive: true);
    }
    return configFile;
  }

  static updateCheckToday() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    File configFile = await getFileConfig();
    YamlMap text = loadYaml(await configFile.readAsString());
    Map<dynamic, dynamic> textEditabele = Map.from(text);
    textEditabele['last_update_check'] = formatted;

    print(jsonEncode(textEditabele));
  }

  static Future<bool> updateIsCheckingToday() async {
    File configFile = await getFileConfig();

    var text = loadYaml(await configFile.readAsString());
    if (text == null || text.isEmpty) {
      return false;
    }
    print(text);

    return false;
  }
}
