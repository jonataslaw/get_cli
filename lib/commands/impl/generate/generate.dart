import 'package:get_cli/core/generator.dart';

mixin GenerateMixin {
  final _args = GetCli.arguments;

  String get on {
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
}
