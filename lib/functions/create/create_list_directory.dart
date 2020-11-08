import 'dart:io';

Future<void> createListDirectory(List<Directory> dirs) async {
  for (final element in dirs) {
    await element.create(recursive: true);
  }
}
