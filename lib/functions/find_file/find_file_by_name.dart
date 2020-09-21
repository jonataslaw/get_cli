import 'dart:io';

File findFileByName(String name) {
  Directory current = Directory('./lib');
  final list = current.listSync(recursive: true, followLinks: false);
  File contains = list.firstWhere((element) {
    //Fix erro ao encontrar arquivo com nome
    if (element is File) {
      return element.path.contains(name);
    }
    return false;
  }, orElse: () {
    return null;
  });
  return contains;
}
