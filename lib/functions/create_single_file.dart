import 'package:args/args.dart';
import 'package:get_cli/get_cli.dart';
import 'package:recase/recase.dart';

Future handleFileCreate(ArgResults results) async {
  await defaultGenerator.createFile(
      fileModel: FileModel(
    result: results['name'],
    path: Structure.getPathWithName(
      defaultStructure.getPathByKey(results.command.name),
      ReCase(results['name']).snakeCase,
      createWithWrappedFolder: results['extraFolder'],
    ),
    commandName: results.command.name,
  ));
}
