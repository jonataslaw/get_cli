import 'package:flutter/material.dart';
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
  