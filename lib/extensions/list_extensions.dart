extension ListExtensions<T> on List<T> {
  T? firstOrNull() {
    if (isEmpty) {
      return null;
    }
    return this[0];
  }
}
