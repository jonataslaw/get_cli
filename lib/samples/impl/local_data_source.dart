import 'package:get_cli/samples/interface/sample_interface.dart';

/// [Sample] file from Module_View file creation.
class LocalDataSourceSample extends Sample {
  final String _name;

  LocalDataSourceSample(String path, this._name, {bool overwrite = false})
      : super(path, overwrite: overwrite);

  @override
  String get content => '''

class $_name  {
 
}
  ''';
}
