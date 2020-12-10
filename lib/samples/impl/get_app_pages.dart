import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';

/// [Sample] file from [app_pages] file creation.
class AppPagesSample extends Sample {
  String initial;
  AppPagesSample(
      {String path = 'lib/app/routes/app_pages.dart', this.initial = 'HOME'})
      : super(path);
  final import = PubspecUtils.getPackageImport;
  String get _initialRoute =>
      initial != null ? '\nstatic const INITIAL = Routes.$initial;' : '';

  @override
  Future<String> get content async => '''$import
part 'app_routes.dart';

class AppPages {
  $_initialRoute

  static final routes = [
  ];
}
''';
}
