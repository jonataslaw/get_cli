import '../interface/sample_interface.dart';

/// [Sample] file from analysis_options.yaml file creation.
class AnalysisOptionsSample extends Sample {
  AnalysisOptionsSample({String path = 'analysis_options.yaml'})
      : super(path, overwrite: true);

  @override
  String get content => '''include: package:pedantic/analysis_options.yaml
linter:
  rules:
    omit_local_variable_types: false
    prefer_collection_literals: false
''';
}
