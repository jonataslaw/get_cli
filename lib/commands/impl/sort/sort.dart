import 'dart:io';

import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';
import 'package:get_cli/functions/create/create_single_file.dart';

class SortCommand extends Command with ArgsMixin {
  @override
  Future<void> execute() async {
    String path = args[1] == '.' ? 'lib' : args[1];
    if (FileSystemEntity.isDirectorySync(path)) {
      sortImportsDirectory(path);
    } else if (FileSystemEntity.isFileSync(path)) {
      sortImportsFile(path);
    } else {
      throw CliException('"$path" is not a valid file or directory');
    }
  }

  @override
  String get hint => 'Sort imports and format dart files';

  @override
  bool validate() {
    if (flags.isNotEmpty) {
      LogService.info('The $flags is not necessary');
    }
    if (args.length < 2) {
      throw CliException('Needed to pass the file or directory path',
          codeSample: 'get sort lib/app \n'
              'or\n'
              'get sort lib/main.dart\n'
              'or\n'
              'get sort .');
    } else if (args.length > 2) {
      throw CliException('The ${args.skip(2).toList()} is not necessary',
          codeSample: 'get sort lib/app \n'
              'or\n'
              'get sort lib/main.dart\n'
              'or\n'
              'get sort .');
    }
    return true;
  }

  void sortImportsDirectory(String path) {
    Directory(path)
        .listSync(recursive: true, followLinks: false)
        .forEach((element) {
      if (element is File && element.path.endsWith('.dart')) {
        writeFile(element.path, element.readAsStringSync(),
            overwrite: true, logger: false);
        LogService.success('"${element.path}" was successfully formatted');
      }
    });
  }

  void sortImportsFile(String path) {
    if (path.endsWith('.dart') && File(path).existsSync()) {
      writeFile(path, File(path).readAsStringSync(),
          overwrite: true, logger: false);
      LogService.success('"${path}" was successfully formatted');
    } else {
      throw CliException('"$path" is not a valid dart file');
    }
  }
}
