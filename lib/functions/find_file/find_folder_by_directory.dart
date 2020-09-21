import 'dart:io';

Directory findFolderByName(String name) {
  Directory current = Directory('./lib');
  final list = current.listSync(recursive: true, followLinks: false);
  Directory contains = list.firstWhere((element) {
    //Fix erro ao encontrar arquivo com nome
    if (element is Directory) {
      return element.path.contains(name);
    }
    return false;
  }, orElse: () {
    return null;
  });
  return contains;
}
