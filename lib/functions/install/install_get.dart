import 'package:get_cli/functions/install/install.dart';
import 'package:get_cli/functions/install/remove.dart';

Future<void> installGet() async {
  await removePackage(['get'], updatePubspec: false);
  await installPackage(['get']);
}
