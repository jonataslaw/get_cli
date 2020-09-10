import 'package:get_cli/samples/interface/sample_interface.dart';

class AppPagesSample extends Sample {
  String initial;
  String import;
  AppPagesSample(
      {String path = 'lib/routes/app_pages.dart',
      this.import = '''import 'package:get/get.dart';''',
      this.initial = 'HOME'})
      : super(path);

  String get _initial =>
      initial != null ? '\nstatic const INITIAL = Routes.$initial;' : '';

  @override
  Future<String> get content async => ''' $import
part 'app_routes.dart';

class AppPages {
  $_initial

  static final routes = [
  ];
}
''';
}
