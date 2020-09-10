import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:get_cli/commands/impl/create/create.dart';
import 'package:get_cli/commands/impl/init/init.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:recase/recase.dart';

class CreateProjectCommand extends Command with CreateMixin {
  @override
  Future<void> execute() async {
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
  }

  @override
  String get hint => 'Use to generate new project';

  @override
  bool validate() {
    return true;
  }
}
