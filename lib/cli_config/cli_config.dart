import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart';

class CliConfig {
  static final DateFormat _formatter = DateFormat('yyyy-MM-dd');
  // Em devsevolvimento
  static File getFileConfig() {
    String scriptFile = Platform.script.toFilePath();
    String path = join(dirname(scriptFile), '.get_cli.yaml');
    File configFile = File(path);
    if (!configFile.existsSync()) {
      configFile.createSync(recursive: true);
    }
    return configFile;
  }

  static void setUpdateCheckToday() {
    final DateTime now = DateTime.now();

    final String formatted = _formatter.format(now);
    File configFile = getFileConfig();
    List<String> lines = configFile.readAsLinesSync();
    int lastUpdateIndex = lines.indexWhere(
      (element) => element.startsWith('last_update_check:'),
    );
    if (lastUpdateIndex != -1) {
      lines.removeAt(lastUpdateIndex);
    }

    lines.add('last_update_check: $formatted');
    configFile.writeAsStringSync(lines.join('\n'));
  }

  static bool updateIsCheckingToday() {
    File configFile = getFileConfig();

    var lines = configFile.readAsLinesSync();
    int lastUpdateIndex = lines.indexWhere(
      (element) => element.startsWith('last_update_check:'),
    );
    if (lines == null || lines.isEmpty || lastUpdateIndex == -1) {
      return false;
    }
    String dateLatsUpdate = lines[lastUpdateIndex].split(':').last.trim();
    DateTime now = _formatter.parse(_formatter.format(DateTime.now()));

    return _formatter.parse(dateLatsUpdate).isBefore(now);
  }
}
