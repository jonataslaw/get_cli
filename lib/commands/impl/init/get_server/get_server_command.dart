import 'dart:io';

import 'package:path/path.dart';

import '../../../../common/utils/pubspec/pubspec_utils.dart';
import '../../../../samples/impl/analysis_options.dart';
import '../../../../samples/impl/get_server/pubspec.dart';
import '../../../interface/command.dart';
import '../flutter/init_getxpattern.dart';

class InitGetServer extends Command {
  @override
  String get commandName => 'init';
  @override
  Future<void> execute() async {
    // bool canContinue = await createMain();
    // if (!canContinue) return;

    await GetServerPubspecSample(basename(Directory.current.path)).create();
    await AnalysisOptionsSample().create();
    await PubspecUtils.addDependencies('get_server', runPubGet: false);
    await PubspecUtils.addDependencies('pedantic',
        isDev: true, runPubGet: false);
    await PubspecUtils.addDependencies('test', isDev: true, runPubGet: false);

    await createInitGetxPattern();
  }

  @override
  String get hint => 'Generate the  structure initial for get server';

  @override
  bool validate() {
    return true;
  }
}
