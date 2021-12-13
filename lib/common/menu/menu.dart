import 'package:cli_dialog/cli_dialog.dart';

class Menu {
  final List<String> choices;
  final String title;

  Menu(this.choices, {this.title = ''});

  T choose<T>() {
    final dialog = CLI_Dialog(listQuestions: [
      [
        {'question': title, 'options': choices},
        'result'
      ]
    ]);
    final answer = dialog.ask();
    return answer['result'] as T;
  }
}
