import 'package:get_cli/samples/interface/sample_interface.dart';

class MainSample extends Sample {
  @override
  String file(String fileName, {bool isArc = false}) {
    return !isArc
        ? '''import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/route.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: Routes.initial,
      getPages: Routes.paths,
    ),
  );
}
  '''
        : '''import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {

  var initialRoute = await Routes.initialRoute;
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      getPages: Nav.routes,
    );
    
  }
}''';
  }
}
