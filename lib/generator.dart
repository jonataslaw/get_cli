import 'dart:io';
import 'package:args/args.dart';
import 'package:get_cli/file_model.dart';
import 'package:get_cli/sample_interface.dart';
import 'package:get_cli/structure.dart';
import 'package:recase/recase.dart';
import 'functions/create_page.dart';
import 'functions/create_init.dart';
import 'functions/create_route.dart';
import 'functions/create_single_file.dart';

/// This is an defaultGenerator which takes [defaultStructure] as an parameter.
Generator defaultGenerator = Generator(currentStructure: defaultStructure);

/// Generator takes an [Structure] object, to specify where to create .dart files
class Generator {
  final Structure currentStructure;

  Generator({
    this.currentStructure,
  }) : assert(currentStructure != null);

  /// This function only handles file creation
  Future<File> createFile({FileModel fileModel, Sample content}) async {
    var reCase = ReCase(fileModel.result);
    var _file = await File(fileModel.path + '.dart').create(recursive: true);
    await _file.writeAsString(content.file(reCase.pascalCase));

    print(
        'file created succesfully with name :${fileModel.result} at path: ${fileModel.path}');
    return _file;
  }
}

/// Essa função é chamada pela main, e recebe os argumentos da cli
Future<void> generate({
  ArgResults results,
  Generator generator,
}) async {
  switch (results.command.name) {
    case "route":
      await createRoute();
      break;
    case "init":
      await createinit();
      break;
    case "page":
      await createPage(results);
      break;
    case "widget":
      await handleFileCreate(results);
      break;
    case "data":
      await handleFileCreate(results);
      break;
    case "model":
      await handleFileCreate(results);
      break;
    case "view":
      await handleFileCreate(results);
      break;
    case "controller":
      await handleFileCreate(results);
      break;
  }
}
