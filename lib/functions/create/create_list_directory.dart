import 'dart:io';

Future<void> createListDirectory(List<Directory> dirs) async {
  dirs.forEach((element) async {
    await element.create(recursive: true);
  });
}
