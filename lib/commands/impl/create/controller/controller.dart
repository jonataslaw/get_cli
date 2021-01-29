import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart';

import '../../../../common/utils/pubspec/pubspec_utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../../exception_handler/exceptions/cli_exception.dart';
import '../../../../functions/binding/add_dependencies.dart';
import '../../../../functions/binding/find_bindings.dart';
import '../../../../functions/create/create_single_file.dart';
import '../../../../functions/is_url/is_url.dart';
import '../../../../functions/replace_vars/replace_vars.dart';
import '../../../../samples/impl/get_controller.dart';
import '../../../interface/command.dart';
import '../../args_mixin.dart';

/**
 * This command is a controller with the template:
 *      
 *      import 'package:get/get.dart';,
 *
 *      class NameController extends GetxController {
 *
 *      }
*/
class CreateControllerCommand extends Command with ArgsMixin {
  @override
  String get hint => LocaleKeys.hint_create_controller.tr;

  String get codeSample =>
      'get create controller:name [OPTINAL PARAMETERS] \n' +
      LocaleKeys.optional_parameters.trArgs(['[on, with]']);
  @override
  bool validate() {
    if (args.length > 2) {
      List<String> unnecessary_parameter = args.skip(2).toList();
      throw CliException(
          LocaleKeys.error_unnecessary_parameter.trArgsPlural(
            LocaleKeys.error_unnecessary_parameter_plural,
            unnecessary_parameter.length,
            [unnecessary_parameter.toString()],
          ),
          codeSample: codeSample);
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
          throw CliException(
              LocaleKeys.error_failed_to_connect.trArgs([withArgument]));
        }
      } else {
        File file = File(withArgument);
        if (file.existsSync()) {
          String content = file.readAsStringSync();
          sample.customContent = replaceVars(content, name);
        } else {
          throw CliException(
              LocaleKeys.error_no_valid_file_or_url.trArgs([withArgument]));
        }
      }
    }
    File controllerFile = await handleFileCreate(
      name,
      'controller',
      onCommand,
      true,
      sample,
      'controllers',
    );

    String binindingPath =
        findBindingFromName(controllerFile.path, basename(onCommand));
    List<String> pathSplit = Structure.safeSplitPath(controllerFile.path);
    pathSplit.remove('.');
    pathSplit.remove('lib');
    if (binindingPath.isNotEmpty) {
      addDependencyToBinding(binindingPath, name, pathSplit.join('/'));
    }
  }
}
