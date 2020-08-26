import 'dart:io';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/samples/impl/get_route.dart';
import 'package:recase/recase.dart';
import '../../models/file_model.dart';

Future<void> createRoute({bool isArc = false, String initial = 'null'}) async {
  FileModel _fileModel = Structure.model('', 'route', false);

  ReCase reCase = ReCase(_fileModel.name);

  await writeFile(
      isArc
          ? (Structure.replaceAsExpected(
              path: 'lib/infrastructure/navigation/routes.dart'))
          // acho que o nome do arquivo no getx_patten é app_routes
          : (_fileModel.path + "route.dart"),
      RouteSample().file(reCase.pascalCase, isArc: isArc, initial: initial));

  LogService.success("Routes created succesfully.");
}
