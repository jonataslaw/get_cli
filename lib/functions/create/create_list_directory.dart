import 'dart:io';

void createListDirectory(List<Directory> dirs) {
  for (final element in dirs) {
    element.createSync(recursive: true);
  }
}
