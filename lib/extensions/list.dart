extension ListExtension<T> on List<T> {
  /// Edit all elements of a list
  List<T> replaceAll(T Function(T element) function) {
    for (int i = 0; i < length; i++) {
      this[i] = function(this[i]);
    }
    return this;
  }
}
