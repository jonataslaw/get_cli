import 'package:get_cli/core/generator.dart';

mixin ArgsMixin {
  final List<String> _args = GetCli.arguments;
  List<String> args = _getArgs();

  String get onCommand {
    int onIndex = _getIndexArg('on');
    return onIndex != -1 ? _args[onIndex + 1] : null;
  }

  String get withArgument {
    int withIndex = _getIndexArg('with');
    return withIndex != -1 ? _args[withIndex + 1] : null;
  }

  String get fromArgument {
    int fromIndex = _getIndexArg('from');

    return fromIndex != -1 ? _args[fromIndex + 1] : null;
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
    if (indexArg != -1) {
      args..removeAt(indexArg)..removeAt(indexArg);
    }
  });
  args.removeWhere((element) => element.startsWith('-'));
  return args;
}

int _getIndexArg(String arg) {
  return GetCli.arguments.indexWhere((element) => element == arg);
}
