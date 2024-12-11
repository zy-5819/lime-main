// import 'dart:async';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:lime/services/logout_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService2 extends FeatureFlagsService {
//   final Ref _ref;
//   late SharedPreferences _prefs;
//   late AuthRpcClient _auth;

//   AuthService2(this._ref) : super(_ref) {
//     _prefs = _ref.watch(sharedPreferencesProvider);
//     _auth = AuthRpcClient(_ref.watch(channelProvider), interceptors: [
//       LogoutInterceptor(
//         onLoggedOutDetected: onLoggedOutDetected,
//         callOptions: options,
//       )
//     ]);
//   }

//   ///获取当前用户的[UserCodeResponse]
//   Future<UserCodeResponse> userCode() async {
//     try {
//       return await _auth.userCode(Empty());
//     } on GrpcError catch (e) {
//       Log.d('auth_service/usercode:${e.message}');
//       rethrow;
//     }
//   }

//   ///获取用户信息[UserDto]
//   Future<UserDto> getUser() async {
//     String? feature;
//     try {
//       final me = await _auth.me(Empty());
//       feature = me.featureFlags;
//       return me;
//     } on GrpcError catch (e) {
//       Log.d('auth_service:${e.message},codeName=${e.codeName}');
//       rethrow;
//     } finally {
//       final accessToken = await _auth.refresh(Empty());
//       await _updateUserAccessInfo(accessToken, feature);
//     }
//   }

//   ///验证当前用户绑定的手机号码
//   Future<void> verifyPhoneNumber(
//       String sessionId, String verificationCode) async {
//     try {
//       await _auth.verifyPhoneNumber(VerifyPhoneNumberRequest(
//           sessionId: sessionId, code: verificationCode));
//     } on GrpcError catch (e) {
//       Log.d('auth_service/verifyPhoneNumber:${e.message}');
//       rethrow;
//     }
//   }

//   ///更换用户绑定的手机号码
//   Future<void> updatePhoneNumber(
//       String sessionId, String verificationCode) async {
//     try {
//       await _auth.updatePhoneNumber(UpdatePhoneNumberRequest(
//           sessionId: sessionId, code: verificationCode));
//     } on GrpcError catch (e) {
//       Log.d('auth_service/updatePhoneNumber:${e.message}');
//       rethrow;
//     }
//   }

//   ///发送验证码
//   Future<String> sendVerificationCode(
//       String phoneNumber, ProtoCodeUsage codeUsage) async {
//     try {
//       final response = await _auth.sendVerificationCode(
//           SendVerificationCodeRequest(
//               phoneNumber: phoneNumber, codeUsage: codeUsage));
//       return response.id;
//     } on GrpcError catch (e) {
//       Log.d('auth_service/sendVerificationCode:${e.message}');
//       rethrow;
//     }
//   }

//   ///使用用户名密码进行登录
//   Future<void> loginWithPassword(String username, String password) async {
//     try {
//       final response = await _auth
//           .login(PasswordLoginRequest(userName: username, password: password));
//       await _setUserAccessInfo(response);
//     } on GrpcError catch (e) {
//       Log.d('auth_service/loginWithPassword:${e.message}');
//       rethrow;
//     }
//   }

//   ///使用手机号码和验证码登录
//   Future<void> loginWithVerificationCode(
//       String sessionId, String verificationCode) async {
//     try {
//       final response = await _auth.loginWithVerificationCode(
//           VerificationCodeLoginRequest(
//               sessionId: sessionId, code: verificationCode));
//       await _setUserAccessInfo(response);
//     } on GrpcError catch (e) {
//       Log.d('auth_service/loginWithVerificationCode:${e.message}');
//       rethrow;
//     }
//   }

//   Future<void> _setUserAccessInfo(AccessToken accessToken) async {
//     final me = await _auth.me(Empty(),
//         options: CallOptions(
//             metadata: {"Authorization": "Bearer ${accessToken.token}"}));
//     await _prefs.setString(
//         SharedPreferenceKeys.kUserAccess,
//         UserAccessInfo(
//                 token: accessToken.token,
//                 expiry: accessToken.expiry.toDateTime(),
//                 flags: me.featureFlags)
//             .toString());
//   }

//   Future<void> _updateUserAccessInfo(
//       AccessToken accessToken, String? featureFlags) async {
//     await _prefs.setString(
//         SharedPreferenceKeys.kUserAccess,
//         UserAccessInfo(
//                 token: accessToken.token,
//                 expiry: accessToken.expiry.toDateTime(),
//                 flags: featureFlags)
//             .toString());
//   }

//   Future<void> logout() async {
//     try {
//       await _prefs.remove(SharedPreferenceKeys.kUserAccess);
//     } catch (e) {
//       Log.e('auth_service/logout: $e');
//     }
//   }

//   ///确认设备的登录操作。
//   Future<Empty> confirmDeviceLogin(String? code, bool? accepted) async {
//     try {
//       final auth = AuthRpcClient(_ref.read(channelProvider));
//       return await auth.confirmDeviceLogin(
//           ConfirmDeviceLoginRequest(code: code, accepted: accepted));
//     } on GrpcError catch (e) {
//       Log.d('auth_service/confirmDeviceLogin:${e.message}');
//       rethrow;
//     }
//   }
// }

// Future<String> sendVerificationCode(
//     String phoneNumber, ProtoCodeUsage codeUsage) async {
//   final stub = AuthRpcClient(channel);
//   try {
//     final response = await stub.sendVerificationCode(
//         SendVerificationCodeRequest(
//             phoneNumber: phoneNumber, codeUsage: codeUsage));
//     return response.id;
//   } catch (e) {
//     return "";
//   }
// }

// class AuthService {
//   const AuthService(this._ref);
//   final Ref _ref;

//   Future<String?> sendVerificationCode(
//       String phoneNumber, ProtoCodeUsage codeUsage) async {
//     final stub = AuthRpcClient(channel);
//     try {
//       final response = await stub.sendVerificationCode(
//           SendVerificationCodeRequest(
//               phoneNumber: phoneNumber, codeUsage: codeUsage));
//       _ref
//           .read(signupSessionIdProvider.notifier)
//           .update((state) => response.id);
//       return null;
//     } on GrpcError catch (e) {
//       return e.message;
//     }
//   }
// }
