import 'dart:io';

import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/is_url/is_url.dart';
import 'package:get_cli/functions/replace_vars/replace_vars.dart';
import 'package:get_cli/samples/impl/get_view.dart';
import 'package:http/http.dart';
import 'package:recase/recase.dart';

class CreateViewCommand extends Command with ArgsMixin {
  @override
  String get hint => 'generate view';

  @override
  bool validate() {
    return true;
  }

  @override
  Future<void> execute() async {
    return createView(name, withArgument: withArgument, onCommand: onCommand);
  }
}

Future<void> createView(String name,
    {String withArgument = '', String onCommand = ''}) async {
  GetViewSample sample = GetViewSample(
    '',
    name.pascalCase + 'View',
    null,
    null,
    PubspecUtils.isServerProject,
  );
  if (withArgument.isNotEmpty) {
    if (isURL(withArgument)) {
      Response res = await get(withArgument);
      if (res.statusCode == 200) {
        String content = res.body;
        sample.customContent = replaceVars(content, name);
      } else {
        CliException('failed to connect with $withArgument');
      }
    } else {
      File file = File(withArgument);
      if (file.existsSync()) {
        String content = file.readAsStringSync();
        sample.customContent = replaceVars(content, name);
      } else {
        CliException('$withArgument  is not a file or valid url');
      }
    }
  }

  await handleFileCreate(name, 'view', onCommand, true, sample, 'views');
}
