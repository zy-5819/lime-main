import 'package:uuid/uuid.dart';

const String kTestServerUrl = 'testServerUrl';
const String kServerVersion = 'ServerVersion';
const String kToken = 'token';
const String kExpiry = 'expiry';
const String kTheme = 'theme';
const String kCurrentGroupId = "currentGroupId";
const String kUserProfileImage = 'images/pic1.jpg';
const String kSplash1 = 'images/splash-1.svg';
const String kSplash2 = 'images/splash-2.svg';
const String kSplash3 = 'images/splash-3.svg';
const String kAppIcon = 'images/app-icon.svg';
const String dustbin = 'images/dustbin.svg';
const String dustbinFull = 'images/dustbin_full.svg';
const String cleanser = 'images/cleanser.svg';
const String cleanserEmpty = 'images/cleanser_empty.svg';

const kUserFlags = ['basic'];
const kRobotOperationSystem = [
  'cleaner',
  'tour',
  'sanitizer',
  'adbot',
  'neighbor'
];

class SharedPreferenceKeys {
  /// 是否显示运行管理页面的服务数据详情。
  static String kServiceStatusDetailsVisible = 'serviceStatusDetailsVisible';

  /// 用户的登录信息，包括token，expiry，flags
  static String kUserAccess = 'userAccess';
}

const uuid = Uuid();

class FeatureFlags {
  static String basic = 'basic';
}
