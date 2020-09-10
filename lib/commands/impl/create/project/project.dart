import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/commands/impl/create/create.dart';
import 'package:get_cli/commands/impl/init/flutter/init.dart';
import 'package:get_cli/commands/impl/init/get_server/get_server_command.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:recase/recase.dart';

class CreateProjectCommand extends Command with CreateMixin {
  @override
  Future<void> execute() async {
    final menu = Menu([
      'Flutter Project',
      'Get Server',
    ]);
    final result = menu.choose();
    if (result.index == 0) {
      String path = name == '.'
          ? Directory.current.path
          : Structure.replaceAsExpected(
              path: Directory.current.path + '/${name.snakeCase}');
      final dialog = CLI_Dialog(questions: [
        [
          'What is your company\'s domain? \x1B[33m example: com.yourcompany \x1B[0m',
          'org'
        ]
      ]);
      final org = dialog.ask()['org'];

      await ShellUtils.flutterCreate(path, org);
      Directory.current = path;
      await InitCommand().execute();
    } else {
      if (name == '.') {
        await InitGetServer().execute();
      } else {
        String path = Structure.replaceAsExpected(
            path: Directory.current.path + '/${name.snakeCase}');
        await Directory(path).create(recursive: true);
        Directory.current = path;
        await InitGetServer().execute();
      }
    }
  }

  @override
  String get hint => 'Use to generate new project';

  @override
  bool validate() {
    return true;
  }
}
