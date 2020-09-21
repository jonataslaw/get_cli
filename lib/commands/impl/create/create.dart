import 'package:get_cli/core/generator.dart';

mixin CreateMixin {
  final _args = GetCli.arguments;

  String get onCommand {
    int onIndex = _args.indexWhere(
      (element) => element == 'on',
    );
    return onIndex != -1 ? _args[onIndex + 1] : null;
  }

  String get withArgument {
    int withIndex = _args.indexWhere(
      (element) => element == 'with',
    );
    return withIndex != -1 ? _args[withIndex + 1] : null;
  }

  String get fromArgument {
    int fromIndex = _args.indexWhere(
      (element) => element == 'from',
    );
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
}
