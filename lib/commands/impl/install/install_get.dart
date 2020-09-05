import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';

Future<void> installGet() async {
  await PubspecUtils.removeDependencies('get');
  await PubspecUtils.addDependencies('get');
}
