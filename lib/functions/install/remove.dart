import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';

Future<void> removePackage(List<String> args,
    {bool updatePubspec = true}) async {
  if (args.isEmpty || args.length == 1) {
    LogService.error('enter the name of a package');
    LogService.info('''example:
  get remove http
''');
    return;
  }

  args.removeAt(0);

  var package = args.first;
  if (args.length == 1) {
    await PubspecUtils.removeDependencies(package);
  } else {
    for (var element in args) {
      // Alterei os logs. Motivo: aqui ele pode remover mais de um package e so estava sendo informado o primeiro
      await PubspecUtils.removeDependencies(element);
    }
  }
  if (updatePubspec) {
    await ShellUtils.pubGet();
  }
}
