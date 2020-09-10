import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/samples/impl/arctekko/arc_routes.dart';
import 'package:get_cli/samples/impl/get_route.dart';

Future<void> createRoute({bool isArc = false, String initial = 'null'}) async {
  isArc ? await ArcRouteSample(initial).create() : await RouteSample().create();

  LogService.success('Routes created successfully.');
}
