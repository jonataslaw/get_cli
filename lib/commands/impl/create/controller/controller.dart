import 'dart:io';

import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';
import 'package:get_cli/functions/binding/add_dependencies.dart';
import 'package:get_cli/functions/binding/find_bindings.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/is_url/is_url.dart';
import 'package:get_cli/functions/replace_vars/replace_vars.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

class CreateControllerCommand extends Command with ArgsMixin {
  @override
  String get hint => 'generate controller';

  @override
  bool validate() {
    if (args.length > 2) {
      throw CliException('the ${args[2]} parameter is not necessary',
          codeSample: 'get create controller:name [OPTINAL PARAMETERS] \n'
              'Optional parameters: [on, with]');
    }
    return true;
  }

  @override
  Future<void> execute() async {
    return createController(name,
        withArgument: withArgument, onCommand: onCommand);
  }

  Future<void> createController(String name,
      {String withArgument = '', String onCommand = ''}) async {
    ControllerSample sample =
        ControllerSample('', name, PubspecUtils.isServerProject);
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
    String path = await handleFileCreate(
      name,
      'controller',
      onCommand,
      true,
      sample,
      'controllers',
    );

    String binindingPath = findBindingFromName(path, basename(onCommand));
    List<String> pathSplit = Structure.safeSplitPath(path);
    pathSplit.remove('.');
    pathSplit.remove('lib');
    if (binindingPath != '') {
      addDependencieToBinding(binindingPath, name, pathSplit.join('/'));
    }
  }
}
