import 'dart:io';
import 'package:path/path.dart' as path_lib;
import 'package:pubspec_parse/pubspec_parse.dart';

import '../../functions/create/create_single_file.dart';

/// [Sample] is the Base class in which the files for each command
/// will be built.
abstract class Sample {
  String customContent = '';

  /// The path where the sample file will be added
  String path;

  /// If the file is found in the path, it can be ignored or
  /// overwritten. If overrite = false, the source file will not be changed.
  /// The default is [false].
  bool overwrite;

  /// Store the content that will be written to the file in a String or
  /// Future <String> in that variable. It is used to fill the file created
  /// by path.
  String get content;

  /// Store the (GetX 5 content) that will be written to the file in a String or
  /// Future <String> in that variable. It is used to fill the file created
  /// by path.
  String? get getX5Content;

  /// check if project using GetX 5
  bool isUsingGetX5() {
    final pubspecFile = File(
      path_lib.join(Directory.current.toString(), 'pubspec.yaml'),
    );
    final pubSpec = Pubspec.parse(pubspecFile.readAsStringSync());

    if(pubSpec.dependencies['get'] == null ) return false;

    return pubSpec.dependencies['get'].toString().contains('^5') ||
        pubSpec.dependencies['get'].toString().contains(': 5');
  }

  Sample(this.path, {this.overwrite = false});

  /// This function will create the file in [path] with the
  /// content of [content] or [getX5Content] according to he used get version.
  File create({bool skipFormatter = false}) {
    return writeFile(
      path,
      customContent.isNotEmpty ? customContent : isUsingGetX5() && getX5Content
          != null ? getX5Content! : content,
      overwrite: overwrite,
      skipFormatter: skipFormatter,
      useRelativeImport: true,
    );
  }
}