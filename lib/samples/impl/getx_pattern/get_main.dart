import 'package:get_cli/samples/interface/sample_interface.dart';

class GetXMainSample extends Sample {
  GetXMainSample() : super('lib/main.dart', overwrite: true);

  @override
  Future<String> get content async => '''import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
  ''';
}
