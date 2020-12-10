import 'dart:io';

import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/functions/find_file/find_file_by_name.dart';
import 'package:version/version.dart';

bool get supportChildrenRoutes {
  if (PubspecUtils.isServerProject) {
    return false;
  }
  bool supportChildren = Version.parse('3.21.0')
          .compareTo(PubspecUtils.getPackageVersion('get')) <=
      0;
  if (supportChildren) {
    File routesFile = findFileByName('app_routes.dart');
    if (routesFile.path.isNotEmpty) {
      supportChildren =
          routesFile.readAsLinesSync().contains('abstract class _Paths {') ||
              routesFile.readAsLinesSync().contains('abstract class _Paths {}');
    } else {
      supportChildren = false;
    }
  }
  return supportChildren;
}
