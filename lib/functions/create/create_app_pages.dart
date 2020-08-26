import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/samples/impl/get_app_pages.dart';
import 'package:recase/recase.dart';
import '../../models/file_model.dart';

Future<void> createAppPage() async {
  FileModel _fileModel = Structure.model('', 'route', false);

  ReCase reCase = ReCase(_fileModel.name);

  await writeFile(_fileModel.path + "app_pages.dart",
      AppPagesSample().file(reCase.pascalCase));
}
