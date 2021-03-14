import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:cli_menu/cli_menu.dart';
import 'package:recase/recase.dart';

import '../../../../common/utils/logger/log_utils.dart';
import '../../../../common/utils/pubspec/pubspec_utils.dart';
import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../../samples/impl/analysis_options.dart';
import '../../../interface/command.dart';
import '../../init/flutter/init.dart';
import '../../init/get_server/get_server_command.dart';

class CreateProjectCommand extends Command {
  @override
  String get commandName => 'project';
  @override
  Future<void> execute() async {
    final menu = Menu([
      'Flutter Project',
      'Get Server',
    ]);
    final result = menu.choose();
    var nameProject = name;
    if (name == '.') {
      final dialog = CLI_Dialog(questions: [
        [LocaleKeys.ask_name_to_project.tr, 'name']
      ]);
      nameProject = dialog.ask()['name'] as String;
    }

    var path = Structure.replaceAsExpected(
        path: '${Directory.current.path}/${nameProject.snakeCase}');
    await Directory(path).create(recursive: true);

    Directory.current = path;

    if (result.index == 0) {
      final dialog = CLI_Dialog(questions: [
        [
          '${LocaleKeys.ask_company_domain.tr} \x1B[33m '
              '${LocaleKeys.example.tr} com.yourcompany \x1B[0m',
          'org'
        ]
      ]);

      var org = dialog.ask()['org'] as String;

      LogService.info(LocaleKeys.ask_ios_lang.tr);
      final iosLangMenu = Menu(['Swift', 'Objective-C']);
      final iosResult = iosLangMenu.choose();

      var iosLang = iosResult.index == 0 ? 'swift' : 'objc';

      LogService.info(LocaleKeys.ask_android_lang.tr);
      final androidLangMenu = Menu(['Kotlin', 'Java']);
      final androidResult = androidLangMenu.choose();

      var androidLang = androidResult.index == 0 ? 'kotlin' : 'java';

      LogService.info(LocaleKeys.ask_use_null_safe.tr);
      final nullSafeMenu =
          Menu([LocaleKeys.options_yes.tr, LocaleKeys.options_no.tr]);
      final nullSafeMenuResult = nullSafeMenu.choose();

      var useNullSafe = nullSafeMenuResult.index == 0;

      LogService.info(LocaleKeys.ask_use_linter.tr);
      final linterMenu = Menu(['no', 'Pedantic', 'Effective Dart']);
      final linterResult = linterMenu.choose();

      await ShellUtils.flutterCreate(path, org, iosLang, androidLang);

      File('test/widget_test.dart').writeAsStringSync('');

      if (useNullSafe) {
        await ShellUtils.activatedNullSafe();
      }
      switch (linterResult.index) {
        case 1:
          PubspecUtils.addDependencies('pedantic',
              isDev: true, runPubGet: false);
          AnalysisOptionsSample(
                  include: 'include: package:pedantic/analysis_options.yaml')
              .create();
          break;
        case 2:
          PubspecUtils.addDependencies('effective_dart',
              isDev: true, runPubGet: false);
          AnalysisOptionsSample(
              include: 'include: package:effective_dart/analysis_options.yaml');
          break;
        default:
          AnalysisOptionsSample().create();
      }
      await InitCommand().execute();
    } else {
      await InitGetServer().execute();
    }
  }

  @override
  String get hint => LocaleKeys.hint_create_project.tr;

  @override
  bool validate() {
    return true;
  }

  @override
  String get codeSample => 'get create project';

  @override
  int get maxParameters => 0;
}
