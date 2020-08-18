import '../create/create_main.dart';
import '../create/create_page.dart';
import '../create/create_route.dart';

Future<void> createInitKatekko() async {
  await createRoute();
  await createMain();
  await createPage();

  print("init created succesfully.");
}
