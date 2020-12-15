import 'dart:io';

import 'package:path/path.dart';

import 'package:get_cli/commands/impl/init/flutter/init_getxpattern.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/samples/impl/analysis_options.dart';
import 'package:get_cli/samples/impl/get_server/pubspec.dart';

class InitGetServer extends Command {
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
