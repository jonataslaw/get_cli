import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:cli_menu/cli_menu.dart';
import 'package:recase/recase.dart';

import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../interface/command.dart';
import '../../args_mixin.dart';
import '../../init/flutter/init.dart';
import '../../init/get_server/get_server_command.dart';

class CreateProjectCommand extends Command with ArgsMixin {
  @override
  Future<void> execute() async {
    final menu = Menu([
      'Flutter Project',
      'Get Server',
    ]);
    final result = menu.choose();
    String nameProject = name;
    if (name == '.') {
      final dialog = CLI_Dialog(questions: [
        [LocaleKeys.ask_name_to_project.tr, 'name']
      ]);
      nameProject = dialog.ask()['name'];
    }

    String path = Structure.replaceAsExpected(
        path: Directory.current.path + '/${nameProject.snakeCase}');
    await Directory(path).create(recursive: true);

    Directory.current = path;

    if (result.index == 0) {
      final dialog = CLI_Dialog(questions: [
        [
          LocaleKeys.ask_company_domain.tr +
              ' \x1B[33m' +
              LocaleKeys.example.tr +
              ' com.yourcompany \x1B[0m',
          'org'
        ]
      ]);
      final org = dialog.ask()['org'];

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
