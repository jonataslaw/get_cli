import 'dart:io';

import 'package:http/http.dart';
import 'package:recase/recase.dart';

import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/is_url/is_url.dart';
import 'package:get_cli/functions/replace_vars/replace_vars.dart';
import 'package:get_cli/samples/impl/get_view.dart';
import 'package:get_cli/commands/interface/command.dart';

class CreateViewCommand extends Command {
  @override
  String get commandName => 'view';
  @override
  String? get hint => Translation(LocaleKeys.hint_create_view).tr;

  @override
  bool validate() {
    return true;
  }

  @override
  Future<void> execute() async {
    return createView(name, withArgument: withArgument, onCommand: onCommand);
  }

  @override
  String get codeSample => 'get create view:delete_dialog';

  @override
  int get maxParameters => 0;
}

Future<void> createView(
  String name, {
  String withArgument = '',
  String onCommand = '',
}) async {
  var sample = GetViewSample(
    '',
    '${name.pascalCase}View',
    '',
    '',
    PubspecUtils.isServerProject,
  );
  if (withArgument.isNotEmpty) {
    if (isURL(withArgument)) {
      var res = await get(Uri.parse(withArgument));
      if (res.statusCode == 200) {
        var content = res.body;
        sample.customContent = replaceVars(content, name);
      } else {
        throw CliException(
          LocaleKeys.error_failed_to_connect.trArgs([withArgument]),
        );
      }
    } else {
      var file = File(withArgument);
      if (file.existsSync()) {
        var content = file.readAsStringSync();
        sample.customContent = replaceVars(content, name);
      } else {
        throw CliException(
          LocaleKeys.error_no_valid_file_or_url.trArgs([withArgument]),
        );
      }
    }
  }

  handleFileCreate(name, 'view', onCommand, true, sample, 'views');
}
