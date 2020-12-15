import 'dart:io';

import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
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
      throw CliException(
          LocaleKeys.error_invalid_file_or_directory.trArgs([path]));
    }
  }

  @override
  String get hint => Translation(LocaleKeys.hint_sort).tr;

  String get codeSample => 'get sort lib/app \n'
      'or\n'
      'get sort lib/main.dart\n'
      'or\n'
      'get sort .';

  @override
  bool validate() {
    if (flags.isNotEmpty) {
      LogService.info(LocaleKeys.info_unnecessary_flag.trArgsPlural(
        LocaleKeys.info_unnecessary_flag_prural,
        flags.length,
        [flags.toString()],
      ));
    }
    if (args.length < 2) {
      throw CliException(LocaleKeys.error_required_path.tr,
          codeSample: codeSample);
    } else if (args.length > 2) {
      List pars = args.skip(2).toList();
      throw CliException(
          LocaleKeys.error_unnecessary_parameter.trArgsPlural(
            LocaleKeys.error_unnecessary_parameter_plural,
            pars.length,
            [pars.toString()],
          ),
          codeSample: codeSample);
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
        LogService.success(
            LocaleKeys.sucess_file_formatted.trArgs([element.path]));
      }
    });
  }

  void sortImportsFile(String path) {
    if (path.endsWith('.dart') && File(path).existsSync()) {
      writeFile(path, File(path).readAsStringSync(),
          overwrite: true, logger: false);
      LogService.success(LocaleKeys.sucess_file_formatted.trArgs([path]));
    } else {
      throw CliException(LocaleKeys.error_invalid_dart.trArgs([path]));
    }
  }
}
