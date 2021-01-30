abstract class Command {
  String get commandName;
  List<String> get alias => [];

  /// hint for command line
  String get hint;

  /// validate command line arguments
  bool validate();

  /// execute command
  Future<void> execute();

  /// childrens command
  List<Command> get childrens => [];
}
