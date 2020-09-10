import 'dart:io';

import 'package:get_cli/core/structure.dart';

Future<void> addExport(String path, String line) async {
  File _file = File(Structure.replaceAsExpected(path: path));
  if (!await _file.exists()) {
    await _file.create(recursive: true);
    await _file.writeAsString(line);
    return;
  }
  List<String> lines = await _file.readAsLines();

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

  await _file.writeAsStringSync(lines.join('\n'));
}
