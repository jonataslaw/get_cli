import '../../common/utils/pubspec/pubspec_utils.dart';
import '../interface/sample_interface.dart';

/// [Sample] file from Module_View file creation.
class RemoteDataSourceSample extends Sample {
  final String _name;

  RemoteDataSourceSample(String path, this._name, {bool overwrite = false})
      : super(path, overwrite: overwrite);

  @override
  String get content => '''

class $_name  {


}
  ''';
}
