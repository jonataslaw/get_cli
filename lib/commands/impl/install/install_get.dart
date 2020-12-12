import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';

Future<void> installGet() async {
  PubspecUtils.removeDependencies('get', logger: false);
  await PubspecUtils.addDependencies('get');
}
