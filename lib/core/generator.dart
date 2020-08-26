import 'package:get_cli/common/utils/shell/shel.utils.dart';
import 'package:get_cli/functions/install/install.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/functions/install/remove.dart';
import 'package:get_cli/functions/version/version.dart';
import '../functions/create/create.dart';
import '../functions/init/init_chooser.dart';

class Core {
  /// Main function. It receive typed arguments
  void generate({
    List<String> arguments,
  }) {
    switch (validateArgs(arguments)) {
      case Validation.emptyArgs:
        LogService.error('Error!!! arguments can not be empty');
        break;
      case Validation.errorFirstArgument:
        LogService.error(
            'Error!!! wrong arguments! only $firstArgsAllow are allow how first argument. Example: get create page:home');
        break;
      case Validation.errorSecondArgument:
        LogService.error(
            'Error!!! wrong arguments! only $secondArgsAllow are allow how second arguments of create. Example: get create page:home');
        break;
      case Validation.success:
        runArguments(arguments);
        break;
      default:
        LogService.error('Error!!! Something went wrong');
        break;
    }
  }

  Future<void> runArguments(
    List<String> arguments,
  ) async {
    switch (arguments.first) {
      case "init":
        await createInitial();
        break;
      case "update":
      case "upgrade":
        await ShellUtils.update();
        break;
      case "install":
        arguments.removeAt(0);
        await installPackage(arguments);
        break;
      case "remove":
        arguments.removeAt(0);
        await removePackage(arguments);
        break;
      case "create":
        await create(arguments);
        break;
      case "-version":
      case "-v":
        await versionCommand();
        break;
    }
  }

  List<String> firstArgsAllow = [
    'create',
    'init',
    'update',
    'upgrade',
    'install',
    'remove',
    '-version',
    '-v'
  ];
  List<String> secondArgsAllow = [
    'page',
    'controller',
    'route',
    'project',
    'presentation',
    'view',
    'screen'
  ];

  Validation validateArgs(List<String> arguments) {
    if (arguments == null || arguments.isEmpty) {
      return Validation.emptyArgs;
    }

    if (firstArgsAllow.contains(arguments.first)) {
      if (arguments.first == 'init' ||
          arguments.first == 'update' ||
          arguments.first == 'upgrade' ||
          arguments.first == '-version' ||
          arguments.first == '-v') {
        return Validation.success;
      }

      if (arguments.first == 'create') {
        if (arguments.length <= 1) return Validation.errorSecondArgument;
        final secondArg = arguments[1].split(':').first;
        if (secondArgsAllow.contains(secondArg)) {
          return Validation.success;
        } else {
          return Validation.errorSecondArgument;
        }
      }
      final depList = ['install', 'remove'];
      if (depList.contains(arguments.first) && arguments.length > 1) {
        return Validation.success;
      }
    } else {
      return Validation.errorFirstArgument;
    }
    return Validation.errorSecondArgument;
  }
}

enum Validation {
  success,
  errorFirstArgument,
  errorSecondArgument,
  emptyArgs,
}
