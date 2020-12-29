extension StringExt on String {
  String removeAll(String value) {
    String newValue = replaceAll(value, '');
    //this =  newValue;
    return newValue;
  }
}
