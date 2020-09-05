import 'package:get_cli/core/generator.dart';

mixin CreateMixin {
  final _args = GetCli.arguments;

  String get onCommand =>
      _args.length > 2 && _args[2] == 'on' ? _args[3] : null;

  String get name =>
      _args[1].split(':').length == 1 || _args[1].split(':')[1].isEmpty
          ? (_args[1].split(':').first == 'project' ? '.' : 'home')
          : _args[1].split(':')[1];
}
