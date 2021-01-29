extension StringExt on String {
  /**
   *  Removes all characters.
   * 
   *      var bestPackage = 'GetX'.removeAll('X');
   *      print(bestPackage) // Get;
   * 
   */
  String removeAll(String value) {
    String newValue = replaceAll(value, '');
    //this =  newValue;
    return newValue;
  }
}
