import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/functions/find_file/find_file_by_name.dart';
import 'package:get_cli/samples/impl/get_app_pages.dart';
import 'package:recase/recase.dart';
import 'package:version/version.dart';

Future<void> addAppPage(String name, String path) async {
  File appPagesFile = findFileByName('app_pages.dart');
  if (appPagesFile == null) {
    await AppPagesSample().create();
    appPagesFile = File(AppPagesSample().path);
  }
  var lines = await appPagesFile.readAsLinesSync();

  while (lines.last.isEmpty) {
    lines.removeLast();
  }

  /* 
  Verificar se as utimas linha segue o padrão esperado.
  exemplo: 
        ), // finalizar o getPage 
      ]; // finalizar o array de pages
    } // finaliza a classe

    exemplos de fora do padrão:
    ),];} // tudo na mesma linha
  */
  if (lines.last.trim() != '}') {
    lines.last = lines.last.replaceAll('}', '');
    lines.add('}');
  }
  int indexRoutes = lines
      .indexWhere((element) => element.trim().contains('static final routes'));
  int index =
      lines.indexWhere((element) => element.contains('];'), indexRoutes);
  if (lines[index].trim() != '];') {
    lines[index] = lines[index].replaceAll('];', '');
    index++;
    lines.insert(index, '\t];');
  }

  bool supportChildren = Version.parse('3.21.1')
          .compareTo(PubspecUtils.getPackageVersion('get')) <=
      0;
  int tabEspaces = 2;
  if (supportChildren) {
    List<String> pathSplit = path.split('/');
    pathSplit.removeLast();
    pathSplit
        .removeWhere((element) => element == 'app' || element == 'modules');
    int onPageIndex = -1;
    while (pathSplit.isNotEmpty && onPageIndex == -1) {
      onPageIndex = lines.indexWhere(
          (element) => element
              .contains('Routes.${pathSplit.last.snakeCase.toUpperCase()}'),
          indexRoutes);
    }
    if (onPageIndex != -1) {
      int onPageStartIndex = lines
          .sublist(0, onPageIndex)
          .lastIndexWhere((element) => element.contains('GetPage'));

      int onPageEndIndex = -1;

      if (onPageStartIndex != -1) {
        onPageEndIndex = lines.indexWhere(
            (element) => element.startsWith(
                _getTabs(_countTabs(lines[onPageStartIndex])) + '),'),
            onPageStartIndex);
      } else {
        _logInvalidFormart();
      }
      if (onPageEndIndex != -1) {
        int indexChildrenStart = lines
            .sublist(onPageStartIndex, onPageEndIndex)
            .indexWhere((element) => element.contains('children'));
        if (indexChildrenStart == -1) {
          tabEspaces = _countTabs(lines[onPageStartIndex]) + 1;
          index = onPageEndIndex;
          lines.insert(index, _getTabs(tabEspaces) + 'children: [');
          index++;
          lines.insert(index, _getTabs(tabEspaces) + '],');
          tabEspaces++;
        } else {
          int indexChildrenEnd = -1;
          indexChildrenEnd = lines.indexWhere(
              (element) => element.startsWith(
                  _getTabs(_countTabs(lines[onPageStartIndex]) + 1) + '],'),
              onPageStartIndex);
          if (indexChildrenEnd != -1) {
            index = indexChildrenEnd;
            tabEspaces = _countTabs(lines[onPageStartIndex]) + 2;
          } else {
            _logInvalidFormart();
          }
        }
      } else {
        _logInvalidFormart();
      }
    }
  }

  String nameSnakeCase = name.snakeCase;
  String namePascalCase = name.pascalCase;
  String line = '''${_getTabs(tabEspaces)}GetPage(
${_getTabs(tabEspaces + 1)}name: Routes.${nameSnakeCase.toUpperCase()}, 
${_getTabs(tabEspaces + 1)}page:()=> ${namePascalCase}View(), 
${_getTabs(tabEspaces + 1)}binding: ${namePascalCase}Binding(),
${_getTabs(tabEspaces)}),''';

  String import =
      "import 'package:${await PubspecUtils.getProjectName()}/$path";

  lines.insert(index, line);

  lines.insert(0, import + '/bindings/$name' "_binding.dart';");
  lines.insert(0, import + '/views/$name' + "_view.dart';");

  await appPagesFile.writeAsStringSync(lines.join('\n'));
}

String _getTabs(int tabEspaces) {
  String string = '';
  for (var i = 0; i < tabEspaces; i++) {
    string += '  ';
  }
  return string;
}

int _countTabs(String line) {
  return '  '.allMatches(line).length;
}

void _logInvalidFormart() {
  LogService.info(
      'the app_pages.dart file does not meet the '
      'expected format, fails to create children pages',
      false,
      false);
}
