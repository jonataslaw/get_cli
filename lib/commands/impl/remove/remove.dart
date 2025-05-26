import 'package:get_cli/common/utils/logger/log_utils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';
import 'package:get_cli/commands/interface/command.dart';

class RemoveCommand extends Command {
  @override
  String get commandName => 'remove';
  @override
  Future<void> execute() async {
    for (var package in args) {
      PubspecUtils.removeDependencies(package);
    }

    //if (GetCli.arguments.first == 'remove') {
    await ShellUtils.pubGet();
    //}
  }

  @override
  String? get hint => Translation(LocaleKeys.hint_remove).tr;

  @override
  bool validate() {
    super.validate();
    if (args.isEmpty) {
      CliException(
        LocaleKeys.error_no_package_to_remove.tr,
        codeSample: codeSample,
      );
    }
    return true;
  }

  @override
  String? get codeSample => LogService.code('get remove http');

  @override
  int get maxParameters => 999;
  @override
  List<String> get alias => ['-rm'];
}
