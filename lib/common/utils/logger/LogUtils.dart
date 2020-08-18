import 'package:ansicolor/ansicolor.dart';

class LogService {
  static final AnsiPen _penError = AnsiPen()..red(bold: true);
  static final AnsiPen _penSuccess = AnsiPen()..green(bold: true);
  static final AnsiPen _penInfo = AnsiPen()..yellow(bold: true);
  static void error(msg) {
    print(_penError(msg));
  }

  static void success(msg) {
    print(_penSuccess(msg));
  }

  static void info(msg) {
    print(_penInfo(msg));
  }
}
