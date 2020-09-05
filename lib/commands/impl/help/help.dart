import 'package:get_cli/commands/commands_list.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';

class HelpCommand extends Command {
  @override
  String get hint => 'Show this help';

  @override
  Future<void> execute() async {
    final commandsHelp = _getCommandsHelp(commands, 0);
    LogService.info('''
List available commands:
$commandsHelp
''');
  }

  String _getCommandsHelp(Map commands, int index) {
    var result = '';
    commands.forEach((key, value) {
      if (value is Map) {
        result += '\n' + '  ' * index + key + ':';
        result += _getCommandsHelp(value, index + 1);
        result += '\n';
      } else if (value is Function) {
        final command = value() as Command;
        result += '\n' + '  ' * index + key + ': ' + command.hint;
      }
    });
    return result;
  }

  @override
  bool validate() => true;
}
