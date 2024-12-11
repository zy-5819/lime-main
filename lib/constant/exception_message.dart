class Em {
  static String exception(dynamic e) {
    String message = '出现未知错误啦';
    if (e is OptionsSetException) {
      message = e.message;
    }
    return message;
  }
}

class OptionsSetException implements Exception {
  final String message;
  OptionsSetException({required this.message});
}
