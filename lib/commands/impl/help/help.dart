import '../../../common/utils/logger/log_utils.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../../commands_list.dart';
import '../../interface/command.dart';

class HelpCommand extends Command {
  @override
  String get commandName => 'help';

  @override
  String get hint => Translation(LocaleKeys.hint_help).tr;

  @override
  Future<void> execute() async {
    final commandsHelp = _getCommandsHelp(commands, 0);
    LogService.info('''
List available commands:
$commandsHelp
''');
  }

  String _getCommandsHelp(List<Command> commands, int index) {
    commands.sort((a, b) {
      if (a.commandName.startsWith('-') || b.commandName.startsWith('-')) {
        return b.commandName.compareTo(a.commandName);
      }
      return a.commandName.compareTo(b.commandName);
    });
    var result = '';
    for (var command in commands) {
      result += '\n ${'  ' * index} ${command.commandName}:  ${command.hint}';
      result += _getCommandsHelp(command.childrens, index + 1);
    }
    return result;
  }
  /* String _getCommandsHelp(Map commands, int index) {
    var result = '';
    commands.forEach((key, value) {
      if (value is Map) {
        result += '\n' + '  ' * index + key + ':';
        result += _getCommandsHelp(value, index + 1);
        result += '\n';
      } else if (value is Function) {
        final command = value() as Command;
        result += '\n' + '  ' * index + key + ': ' + command.hint + '\n';
      }
    });
    return result;
  } */

  @override
  bool validate() => true;
}
