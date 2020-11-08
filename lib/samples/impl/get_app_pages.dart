import 'package:get_cli/samples/interface/sample_interface.dart';

/// [Sample] file from [app_pages] file creation.
class AppPagesSample extends Sample {
  String initial;
  String import;
  AppPagesSample(
      {String path = 'lib/app/routes/app_pages.dart',
      this.import = '''import 'package:get/get.dart';''',
      this.initial = 'HOME'})
      : super(path);

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
