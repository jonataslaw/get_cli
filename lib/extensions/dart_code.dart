import 'dart:io';

import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/formatter_dart_file/frommatter_dart_file.dart';

import '../exception_handler/exceptions/cli_exception.dart';
import 'string.dart';

extension DartCodeExt on File {
  /// Append the content of dart class
  /// ``` dart
  /// var newClassContent = '''abstract class Routes {
  ///  Routes._();
  ///
  ///}
  /// abstract class _Paths {
  ///  _Paths._();
  /// }'''.appendClassContent('Routes', 'static const HOME = _Paths.HOME;' );
  /// print(newClassContent);
  /// ```
  /// abstract class Routes {
  /// Routes._();
  /// static const HOME = _Paths.HOME;
  /// }
  /// abstract class _Paths {
  ///  _Paths._();
  /// }
  ///
  void appendClassContent(String className, String value) {
    var content = dartCode;
    var matches =
        RegExp('class $className {.*?(^})', multiLine: true, dotAll: true)
            .allMatches(content);
    if (matches.isEmpty) {
      throw CliException('The class $className is not found in the file $path');
    } else if (matches.length > 1) {
      throw CliException(
          'The class $className is found more than once in the file $path');
    }
    var match = matches.first;
    content = content.insert(match.end - 1, value);
    writeFile(
      path,
      content,
      overwrite: true,
      logger: false,
      useRelativeImport: true,
    );
  }

  String get dartCode {
    return formatterDartFile(readAsStringSync());
  }
}
