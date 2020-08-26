import 'dart:io';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/routes/get_add_route.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_binding.dart';
import 'package:recase/recase.dart';

import '../../core/structure.dart';
import '../../samples/impl/get_controller.dart';
import '../../samples/impl/get_view.dart';

Future<void> createPage([String name = 'home']) async {
  FileModel _fileModel = Structure.model(name, 'page', true);

  ReCase reCase = ReCase(_fileModel.name);

  await writeFile(
      _fileModel.path + "_binding.dart",
      //erro ao criar pages com nome composto
      BindingSample().file(reCase.originalText));

  await writeFile(_fileModel.path + "_view.dart",
      GetViewSample().file(reCase.originalText));

  await writeFile(_fileModel.path + "_controller.dart",
      ControllerSample().file(reCase.pascalCase));
  addRoute(reCase.originalText);

  LogService.success(reCase.pascalCase + " Page created succesfully.");
}
