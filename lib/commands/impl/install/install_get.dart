import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';

Future<void> installGet([bool runPubGet = false]) async {
  PubspecUtils.removeDependencies('get', logger: false);
  await PubspecUtils.addDependencies('get', runPubGet: runPubGet);
}
