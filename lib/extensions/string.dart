extension StringExt on String {
  /// Removes all characters.
  /// ```
  /// var bestPackage = 'GetX'.removeAll('X');
  /// print(bestPackage) // Get;
  /// ```
  String removeAll(String value) {
    var newValue = replaceAll(value, '');
    //this =  newValue;
    return newValue;
  }

  String insert(int index, String value) {
    var newValue = substring(0, index) + value + substring(index);
    return newValue;
  }
}
