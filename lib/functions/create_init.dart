import 'create_main.dart';
import 'create_page.dart';
import 'create_route.dart';

Future<void> createinit() async {
  await createRoute();
  await createMain();
  await createPage();

  print("init created succesfully.");
}
