import 'dart:io';

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

    await ShellUtils.flutterCreate(path);
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
