import 'dart:io';

import 'package:get_cli/commands/impl/init/flutter/init_getxpattern.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/samples/impl/analysis_options.dart';
import 'package:get_cli/samples/impl/get_server/pubspec.dart';
import 'package:path/path.dart';

class InitGetServer extends Command {
  @override
  String get commandName => 'init';
  @override
  Future<void> execute() async {
    // bool canContinue = await createMain();
    // if (!canContinue) return;
    GetServerPubspecSample(basename(Directory.current.path)).create();
    AnalysisOptionsSample(
      include: 'include: package:pedantic/analysis_options.yaml',
    ).create();
    await PubspecUtils.addDependencies('get_server', runPubGet: false);
    await PubspecUtils.addDependencies(
      'pedantic',
      isDev: true,
      runPubGet: false,
    );
    await PubspecUtils.addDependencies('test', isDev: true, runPubGet: false);

    await createInitGetxPattern();
  }

  @override
  String get hint => 'Generate the  structure initial for get server';

  @override
  bool validate() {
    super.validate();

    return true;
  }

  @override
  String get codeSample => '';

  @override
  int get maxParameters => 0;
}
