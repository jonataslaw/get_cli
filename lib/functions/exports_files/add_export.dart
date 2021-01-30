import 'dart:io';

import '../../core/structure.dart';

void addExport(String path, String line) {
  var _file = File(Structure.replaceAsExpected(path: path));
  if (!_file.existsSync()) {
    _file.createSync(recursive: true);
    _file.writeAsStringSync(line);
    return;
  }
  var lines = _file.readAsLinesSync();

  if (lines.length > 1) {
    if (lines.contains(line)) {
      return;
    }
    while (lines.last.isEmpty) {
      /* remover as linhas em branco no final do arquivo 
    gerada pelo o visual studio e outras ide
    */
      lines.removeLast();
    }
  }

  lines.add(line);

  lines.sort();

  _file.writeAsStringSync(lines.join('\n'));
}
