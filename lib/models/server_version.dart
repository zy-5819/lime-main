/// 服务器版本
enum ServerVersion {
  // 正式版
  official,

  // 测试版
  test
}

extension ServerVersionExtensions on ServerVersion {
  String get text {
    switch (this) {
      case ServerVersion.official:
        return '正式版';
      case ServerVersion.test:
        return '测试版';
    }
  }
}
