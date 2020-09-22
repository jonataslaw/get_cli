import 'dart:async';

import 'package:get_cli/functions/create/create_single_file.dart';

abstract class Sample {
  String path;
  bool overwrite;
  FutureOr<String> get content;
  Sample(this.path, {this.overwrite = false});
  Future<void> create() async {
    return await writeFile(path, await content, overwrite: overwrite);
  }
}
