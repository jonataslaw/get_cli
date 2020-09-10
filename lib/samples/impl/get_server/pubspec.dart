import 'package:get_cli/samples/interface/sample_interface.dart';

class GetServerPubspecSample extends Sample {
  String name;
  GetServerPubspecSample(this.name) : super('pubspec.yaml', overwrite: true);

  @override
  Future<String> get content async => '''name: $name
description: A new Get Server application.
version: 1.0.0

dependencies:

dev_dependencies:

''';
}
