import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';

Future<void> removePackage(List<String> args) async {
  if (args.isEmpty || args.length == 1) {
    LogService.error('enter the name of a package');
    LogService.info('''example:
  get remove http
''');
    return;
  }

  args.removeAt(0);

  var package = args.first;
  LogService.info('Removing package: $package');
  if (args.length == 1) {
    await PubspecUtils.removeDependencies(package);
  } else {
    for (var element in args) {
      await PubspecUtils.removeDependencies(element);
    }
  }
  await ShellUtils.pubGet();
  LogService.success('Package: $package removed!');
}
