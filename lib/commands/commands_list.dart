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
    'model': () => GenerateModelCommand(),
  },
  'help': () => HelpCommand(),
  'init': () => InitCommand(),
  'install': () => InstallCommand(),
  'remove': () => RemoveCommand(),
  'update': () => UpdateCommand(),
  'upgrade': () => UpdateCommand(),
  '-v': () => VersionCommand(),
  '-version': () => VersionCommand(),
};
