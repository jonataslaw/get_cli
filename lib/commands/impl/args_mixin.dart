import 'package:http/http.dart';

import 'package:get_cli/core/generator.dart';

mixin ArgsMixin {
  final List<String> _args = GetCli.arguments;
  List<String> args = _getArgs();
  List<String> flags = _getFlags();

  String get onCommand {
    return _getArg('on');
  }

  String get withArgument {
    return _getArg('with');
  }

  String get fromArgument {
    return _getArg('from');
  }

  String get name {
    if (_args.first == 'init') {
      return 'home';
    } else {
      return _args[1].split(':').length == 1 || _args[1].split(':')[1].isEmpty
          ? (_args[1].split(':').first == 'project' ? '.' : 'home')
          : _args[1].split(':')[1];
    }
  }

  bool containsArg(String flag) {
    return _args.contains(flag);
  }
}
List<String> _getArgs() {
  var args = List.of(GetCli.arguments);
  var defaultArgs = ['on', 'home', 'from', 'with'];
  defaultArgs.forEach((arg) {
    int indexArg = args.indexWhere((element) => (element == arg));
    if (indexArg != -1 && indexArg + 1 < args.length) {
      args..removeAt(indexArg)..removeAt(indexArg);
    }
  });
  args.removeWhere((element) => element.startsWith('-'));
  return args;
}

List<String> _getFlags() {
  var args = List.of(GetCli.arguments);

  return args
      .where((element) => element.startsWith('-') && element != '--debug')
      .toList();
}

int _getIndexArg(String arg) {
  return GetCli.arguments.indexWhere((element) => element == arg);
}

String _getArg(String arg) {
  int index = _getIndexArg(arg);
  if (index != -1) {
    if (index + 1 < GetCli.arguments.length) {
      index++;
      return GetCli.arguments[index];
    } else {
      throw ClientException("the '$arg' argument is empty");
    }
  }

  return '';
}
