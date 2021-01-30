import '../commands/commands_list.dart';
import '../commands/impl/help/help.dart';
import '../commands/interface/command.dart';
import '../common/utils/logger/log_utils.dart';

class GetCli {
  final List<String> _arguments;

  GetCli(this._arguments) {
    _instance = this;
  }

  static GetCli _instance;
  static GetCli get to => _instance;

  static List<String> get arguments => to._arguments;

  Command findCommand() => _findCommand(0, commands);

  Command _findCommand(int currentIndex, List<Command> commands) {
    try {
      final currentArgument = arguments[currentIndex].split(':').first;

      var command = commands.firstWhere(
          (command) =>
              command.commandName == currentArgument ||
              command.alias.contains(currentArgument),
          orElse: () => ErrorCommand('command not found'));
      if (command.childrens.isNotEmpty) {
        if (command is CommandParent) {
          command = _findCommand(++currentIndex, command.childrens);
        } else {
          var childrenCommand = _findCommand(++currentIndex, command.childrens);
          if (!(childrenCommand is ErrorCommand)) {
            command = childrenCommand;
          }
        }
      }
      return command;
      // ignore: avoid_catching_errors
    } on RangeError catch (_) {
      return HelpCommand();
    } on Exception catch (_) {
      rethrow;
    }
  }
/* Command findCommand() => _findCommand(0, commands_);

  Command _findCommand(int currentIndex, Map commands) {
    try {
      final currentArgument = arguments[currentIndex].split(':').first;
      final command = commands[currentArgument];
      if (command == null) throw Exception();
      if (command is Function) return command();
      return _findCommand_(currentIndex += 1, command);
    } on CliException catch (e) {
      return ErrorCommand(e.message);
    } on RangeError catch (_) {
      return HelpCommand();
    } catch (e) {
      return ErrorCommand('command not found');
    }
  } */

}

class ErrorCommand extends Command {
  @override
  String get commandName => 'onerror';
  String error;
  ErrorCommand(this.error);
  @override
  Future<void> execute() async {
    LogService.error(error);
    LogService.info('run `get help` to help', false, false);
  }

  @override
  String get hint => 'Print on erro';

  @override
  bool validate() {
    return true;
  }
}

/* class Core {
  // prefix = -•○
  String _getArgsPrintList(args, {String prefix = '•', String spacer = ''}) {
    return args
        .map((e) {
          return spacer + '$prefix $e'; //.padLeft(20, ' ');
        })
        .toList()
        .join('\n');
  }

  /// Main function. It receive typed arguments
  Future<void> generate({
    List<String> arguments,
  }) async {
    final err = LogService.error;
    final cod1 = LogService.code;
    final cod2 = LogService.codeBold;

    switch (validateArgs(arguments)) {
      case Validation.emptyArgs:
        err('''
❌ Error! you need to provide a valid command with arguments.
''');
        break;
      case Validation.errorFirstArgument:
//        final codeSample = LogService.code('get create page:home');
        String codeSample = cod1('get ') + cod2('create') + cod1(' page:home');
        String commandList = _getArgsPrintList(
          firstArgsAllow,
          spacer: ' ' * 2,
        );
        err('''
Error! wrong command 
  Valid commands are
$commandList

  Example:
  $codeSample
''');
        break;
      case Validation.errorSecondArgument:
        String codeSample = cod1('get create ') + cod2('page') + cod1(':home');
        String commandList = _getArgsPrintList(
          secondArgsAllow,
          spacer: ' ' * 2,
        );
        err('''
Error! wrong arguments
  Valid arguments are
$commandList

  Example:
  $codeSample
''');
        break;
      case Validation.success:
        await runArguments(arguments);
        break;
      default:
        LogService.error('''
Error! Sorry, something went wrong
''');
        break;
    }
  }

  Future<void> runArguments(
    List<String> arguments,
  ) async {
    switch (arguments.first) {
      case 'init':
        await createInitial();
        break;
      case 'update':
      case 'upgrade':
        await ShellUtils.update();
        break;
      case 'install':
        arguments.removeAt(0);
        await installPackage(arguments);
        break;
      case 'remove':
        arguments.removeAt(0);
        await removePackage(arguments);
        break;
      case 'create':
        await create(arguments);
        break;
      case 'generate':
        await generators.generate(arguments);
        break;
      case '-version':
      case '-v':
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
    'generate',
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

  List<String> secondGenerateArgsAllow = [
    'locales',
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
      if (depList.contains(arguments.first)) {
        return Validation.success;
      }

      if (arguments.first == 'generate') {
        final secondArg = arguments[1];
        if (!secondGenerateArgsAllow.contains(secondArg)) {
          return Validation.errorSecondArgument;
        }
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
 */
