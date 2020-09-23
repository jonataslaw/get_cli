import 'dart:async';

import 'package:get_cli/samples/interface/sample_interface.dart';

class AnalysisOptionsSample extends Sample {
  AnalysisOptionsSample({String path = 'analysis_options.yaml'})
      : super(path, overwrite: true);

  @override
  FutureOr<String> get content =>
      '''include: package:pedantic/analysis_options.yaml
linter:
  rules:
    omit_local_variable_types: false
    prefer_collection_literals: false
''';
}
