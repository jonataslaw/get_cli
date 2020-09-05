abstract class Command {
  /// hint for command line
  String get hint;

  /// validate command line arguments
  bool validate();

  /// execute command
  Future<void> execute();
}
