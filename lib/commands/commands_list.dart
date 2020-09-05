import 'package:get_cli/commands/impl/commads_export.dart';

final commands = {
  'create': {
    'controller': () => CreateControllerCommand(),
    'page': () => CreatePageCommand(),
    'project': () => CreateProjectCommand(),
    'screen': () => CreateScreenCommand(),
    'view': () => CreateViewCommand(),
  },
  'generate': {
    'locales': () => GenerateLocalesCommand(),
  },
  'help': () => HelpCommand(),
  'init': () => InitCommand(),
  'install': () => InstallCommand(),
  'remove': () => RemoveCommand(),
  'version': () => VersionCommand(),
};
