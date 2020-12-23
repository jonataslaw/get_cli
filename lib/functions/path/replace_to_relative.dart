import 'package:get_cli/core/structure.dart';
import 'package:path/path.dart';

/// Replace the import with a relative path import.
String replaceToRelativeImport(String import, String otherFile) {
  int startImport = import.indexOf('/');
  int endImport = import.lastIndexOf("'");
  String pathImport = import.substring(startImport + 1, endImport);
  List<String> pathSafe = Structure.safeSplitPath(otherFile);
  pathSafe.removeWhere((element) => element == 'lib');
  pathSafe.removeLast();
  otherFile = pathSafe.join('/');

  String newImport = relative(pathImport, from: otherFile);
  newImport = Structure.safeSplitPath(newImport).join('/');
  return "import '$newImport" + import.substring(endImport);
}
