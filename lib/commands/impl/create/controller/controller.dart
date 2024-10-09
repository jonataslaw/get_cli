import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart';

import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';
import 'package:get_cli/functions/binding/add_dependencies.dart';
import 'package:get_cli/functions/binding/find_bindings.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/is_url/is_url.dart';
import 'package:get_cli/functions/replace_vars/replace_vars.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:get_cli/commands/interface/command.dart';

/// This command is a controller with the template:
///```
///import 'package:get/get.dart';,
///
///class NameController extends GetxController {
///
///}
///```
class CreateControllerCommand extends Command {
  @override
  String? get hint => LocaleKeys.hint_create_controller.tr;

  @override
  String get codeSample => 'get create controller:name [OPTINAL PARAMETERS] \n'
      '${LocaleKeys.optional_parameters.trArgs(['[on, with]'])} ';
  @override
  bool validate() {
    super.validate();
    if (args.length > 2) {
      var unnecessaryParameter = args.skip(2).toList();
      throw CliException(
        LocaleKeys.error_unnecessary_parameter.trArgsPlural(
          LocaleKeys.error_unnecessary_parameter_plural,
          unnecessaryParameter.length,
          [unnecessaryParameter.toString()],
        ),
        codeSample: codeSample,
      );
    }
    return true;
  }

  @override
  Future<void> execute() async {
    return createController(
      name,
      withArgument: withArgument,
      onCommand: onCommand,
    );
  }

  Future<void> createController(
    String name, {
    String withArgument = '',
    String onCommand = '',
  }) async {
    var sample = ControllerSample('', name, PubspecUtils.isServerProject);
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
    var controllerFile = handleFileCreate(
      name,
      'controller',
      onCommand,
      true,
      sample,
      'controllers',
    );

    var binindingPath =
        findBindingFromName(controllerFile.path, basename(onCommand));
    var pathSplit = Structure.safeSplitPath(controllerFile.path);
    pathSplit.remove('.');
    pathSplit.remove('lib');
    if (binindingPath.isNotEmpty) {
      addDependencyToBinding(binindingPath, name, pathSplit.join('/'));
    }
  }

  @override
  String get commandName => 'controller';

  @override
  int get maxParameters => 0;
}
