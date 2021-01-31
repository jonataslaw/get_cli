import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:cli_menu/cli_menu.dart';
import 'package:recase/recase.dart';

import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../interface/command.dart';
import '../../init/flutter/init.dart';
import '../../init/get_server/get_server_command.dart';

class CreateProjectCommand extends Command {
  @override
  String get commandName => 'project';
  @override
  Future<void> execute() async {
    final menu = Menu([
      'Flutter Project',
      'Get Server',
    ]);
    final result = menu.choose();
    var nameProject = name;
    if (name == '.') {
      final dialog = CLI_Dialog(questions: [
        [LocaleKeys.ask_name_to_project.tr, 'name']
      ]);
      nameProject = dialog.ask()['name'] as String;
    }

    var path = Structure.replaceAsExpected(
        path: '${Directory.current.path}/${nameProject.snakeCase}');
    await Directory(path).create(recursive: true);

    Directory.current = path;

    if (result.index == 0) {
      final dialog = CLI_Dialog(questions: [
        [
          '${LocaleKeys.ask_company_domain.tr} \x1B[33m '
              '${LocaleKeys.example.tr} com.yourcompany \x1B[0m',
          'org'
        ]
      ]);
      var org = dialog.ask()['org'] as String;
      await ShellUtils.flutterCreate(path, org);
      await InitCommand().execute();
    } else {
      await InitGetServer().execute();
    }
  }

  @override
  String get hint => LocaleKeys.hint_create_project.tr;

  @override
  bool validate() {
    return true;
  }
}
