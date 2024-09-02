import '../interface/sample_interface.dart';

/// [Sample] file from analysis_options.yaml file creation.
class AnalysisOptionsSample extends Sample {
  String include;
  AnalysisOptionsSample(
      {String path = 'analysis_options.yaml', this.include = ''})
      : super(path, overwrite: true);

  @override
  String get content => '''$include
linter:
  rules:
    
''';

  @override
  String? get getX5Content => null;
}
