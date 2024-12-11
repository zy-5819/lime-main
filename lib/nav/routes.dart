import 'package:flutter/material.dart';
import 'package:lime/nav/tabs.dart';
import 'package:lime/pages/login/login_page.dart';
import 'package:lime/pages/message_settings/message_settings_page.dart';
import 'package:lime/pages/message_system_notifications/message_system_notifications_page.dart';
import 'package:lime/pages/message_version_update/message_version_update_page.dart';
import 'package:lime/pages/signup/signup_page.dart';
import 'package:lime/pages/user_password_update/user_password_update_page.dart';
import 'package:lime/pages/user_phone_number_update/user_phone_number_new_page.dart';
import 'package:lime/pages/user_phone_number_update/user_phone_number_verify_page.dart';
import 'package:lime/widgets/qr_code/my_mobile_scanner.dart';
import 'package:lime/widgets/qr_code/qr_view.dart';

Map<String, WidgetBuilder> routes = {
  ///其他
  Routes.login: LoginPage.route,
  Routes.bottomTabs: Tabs.route,
  Routes.signup: SignUpPage.route,
  Routes.qrView: QrView.route,
  Routes.myMobileScanner: MyMobileScanner.route,

  ///用户相关页面
  Routes.userPhoneNumberVerify: UserPhoneNumberVerifyPage.route,
  Routes.userPhoneNumberNew: UserPhoneNumberNewPage.route,
  Routes.userPasswordUpdate: UserPasswordUpdatePage.route,

  ///消息通知相关页面
  Routes.messageSettings: MessageSettingsPage.route,
  Routes.messageVersionUpdate: MessageVersionUpdatePage.route,
  Routes.messageSystemNotifications: MessageSystemNotificationsPage.route,
};

extension BuildContextRouteExtensions on BuildContext {
  /// 从当前导航路由信息中提取类型为[T]的参数。
  T args<T>() => ModalRoute.of(this)!.settings.arguments as T;
}

/// 提供对预定义路由的访问。
class Routes {
  Routes._();

  /// 显示系统通知的页面
  ///
  /// 参数类型：无
  ///
  /// 参数说明：无
  static const messageSystemNotifications = '/messageSystemNotifications';

  /// 通知应用有新版本的消息页面
  ///
  /// 参数类型：无
  ///
  /// 参数说明：无
  static const messageVersionUpdate = '/messageVersionUpdate';

  /// 消息通知的设置页面
  ///
  /// 参数类型：无
  ///
  /// 参数说明：无
  static const messageSettings = '/messageSettings';

  /// 用户更新登录密码的页面。
  ///
  /// 参数类型：无
  ///
  /// 参数说明：无
  static const userPasswordUpdate = '/userPasswordUpdate';

  /// 用户关联新手机号码的页面
  ///
  /// 参数类型：无
  ///
  /// 参数说明：无
  static const userPhoneNumberNew = '/userPhoneNumberNew';

  /// 验证用户目前关联的手机号的页面
  ///
  /// 参数类型： VerifyPhoneNumberArguments
  ///
  /// 参数说明： 表示绑定的手机号码与是否为新绑定的手机号
  static const userPhoneNumberVerify = '/userPhoneNumberVerify';

  /// 用户信息设置页面。
  ///
  /// 无参数
  static const userSettings = '/userSettings';

  ///用户更新显示名的页面
  ///
  /// 参数类型： UserDto
  ///
  /// 参数说明： 表示需要修改显示名的用户
  static const userDisplayNameUpdate = '/userDisplayNameUpdate';

  ///用户展示用户码的页面
  ///
  /// 参数： 无
  static const userCode = '/user_code';

  ///app主页面
  ///
  ///参数： 无
  static const home = '/home';

  ///用户登录页面
  ///
  ///参数： 无
  static const login = '/login';

  ///app底部导航栏
  ///
  ///参数： 无
  static const bottomTabs = '/tabs';

  ///用户注册页面
  ///
  ///参数： 无
  static const signup = '/sign_up';

  /// 查看用户操作设备的日志页面。
  ///
  /// 参数类型：
  ///
  /// 参数说明：
  static const userAuditLogs = '/userAuditLogs';

  /// 用户操作的详情页
  ///
  /// 参数类型：[AuditLogDto]
  ///
  /// 参数说明：操作记录
  static const userAuditLogDetails = '/userAuditLogDetails';

  /// 扫描二维码页面
  ///
  /// 参数类型: [MyMobileScannerArgs]
  ///
  /// 参数说明：扫描二维完成后调用的回调
  static const myMobileScanner = '/myMobileScanner';

  ///扫描二维码组件
  ///
  ///参数： 无
  static const qrView = '/qr_view';
}
