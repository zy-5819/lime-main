// import 'package:capella_app/api/generated/app/user.pbgrpc.dart';
// import 'package:capella_app/api/generated/google/protobuf/any.pb.dart';
// import 'package:capella_app/api/generated/google/protobuf/timestamp.pb.dart';
// import 'package:capella_app/providers/top_level_providers.dart';
// import 'package:capella_app/services/logout_interceptor.dart';
// import 'package:capella_app/services/logout_service.dart';
// import 'package:capella_app/util/log_util.dart';
// import 'package:fixnum/fixnum.dart';
// import 'package:grpc/grpc.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class UserService extends LogoutService {
//   final Ref _ref;
//   late UserRpcClient _user;

//   UserService(this._ref) : super(_ref) {
//     _user = UserRpcClient(_ref.watch(channelProvider), interceptors: [
//       LogoutInterceptor(
//         onLoggedOutDetected: onLoggedOutDetected,
//         callOptions: options,
//       )
//     ]);
//   }

//   ///根据用户码[String]获取用户信息[UserDto]
//   Future<UserDto> getUserCode(String userCode) async {
//     try {
//       return await _user.getByUserCode(UserCode(code: userCode));
//     } on GrpcError catch (e) {
//       Log.d('user_service:getUserCode:${e.message}');
//       rethrow;
//     }
//   }

//   ///根据用户ID[Int64]获取用户信息[UserDto]
//   Future<UserDto> get(Int64 userId) async {
//     try {
//       return await _user.get(GetRequest(id: userId));
//     } on GrpcError catch (e) {
//       Log.d('user_service:get:${e.message}');
//       rethrow;
//     }
//   }

//   ///修改指当前用户的登录密码
//   Future<void> changeMyPassword(String newPwd, String oldPwd) async {
//     try {
//       await _user.changeMyPassword(
//           ChangeMyPasswordRequest(newPassword: newPwd, oldPassword: oldPwd));
//     } on GrpcError catch (e) {
//       Log.d('user_service/changeMyPassword:${e.message}');
//       rethrow;
//     }
//   }

//   ///修改指定用户的显示名称
//   Future<void> update(Int64 userId, String displayName) async {
//     try {
//       await _user
//           .update(UpdateUserRequest(id: userId, displayName: displayName));
//     } on GrpcError catch (e) {
//       Log.d('user_service/update:${e.message}');
//       rethrow;
//     }
//   }

//   Future<List<AuditLogDto>> listAuditLogsBy({
//     DateTime? timeBegin,
//     DateTime? timeEnd,
//     String? keyword,
//     String? username,
//     int page = 1,
//     int pageSize = 20,
//   }) async {
//     try {
//       final response = await _user.listAuditLogs(ListRequest(
//         paging: PagingInfo(page: page, pageSize: pageSize),
//         keyword: keyword,
//         filters: Any.pack(AuditLogFilter(
//             userName: username,
//             timeBegin:
//                 timeBegin == null ? null : Timestamp.fromDateTime(timeBegin),
//             timeEnd: timeEnd == null
//                 ? null
//                 : Timestamp.fromDateTime(
//                     timeEnd.add(const Duration(days: 1))))),
//       ));
//       return response.results;
//     } on GrpcError catch (e) {
//       Log.e('user_service/listAuditLogsBy: ${e.message}');
//       rethrow;
//     }
//   }

//   Future<List<UserDto>> listUsers() async {
//     try {
//       final response = await _user
//           .list(ListRequest(paging: PagingInfo(page: 0, pageSize: 10000)));
//       return response.results;
//     } on GrpcError catch (e) {
//       Log.e('user_service/listUsers: ${e.message}');
//       rethrow;
//     }
//   }

//   Future<List<UserDto>> listBy({
//     int page = 0,
//     int pageSize = 20,
//     String? keyword,
//   }) async {
//     try {
//       final response = await _user.list(
//         ListRequest(
//           keyword: keyword,
//           paging: PagingInfo(page: page, pageSize: pageSize),
//         ),
//       );
//       return response.results;
//     } catch (e) {
//       Log.e('user/listBy: $e.');
//       rethrow;
//     }
//   }

//   Future<void> changePassword(Int64 userId, String password) async {
//     try {
//       await _user.changePassword(
//           ChangePasswordRequest(id: userId, password: password));
//     } on GrpcError catch (e) {
//       Log.e('user_service/changePassword: ${e.message}');
//       rethrow;
//     }
//   }

//   Future<void> setUserFeatureFlags(List<Int64> users, String featureFlags) {
//     try {
//       return _user.setUserFeatureFlags(
//           SetUserFeatureFlagsRequest(users: users, featureFlags: featureFlags));
//     } catch (e) {
//       Log.e('user/setUserFeatureFlags: $e.');
//       rethrow;
//     }
//   }

//   Future<void> setUserRole(Int64? userId, String role) {
//     try {
//       return _user.setUserRole(SetUserRoleRequest(id: userId, role: role));
//     } catch (e) {
//       Log.e('user/setUserRole: $e.');
//       rethrow;
//     }
//   }

//   Future<void> delete(Int64? userId) {
//     try {
//       return _user.delete(DeleteRequest(id: userId));
//     } catch (e) {
//       Log.e('user/delete: $e.');
//       rethrow;
//     }
//   }

//   Future<void> setEnabled(Int64? userId, bool enabled) async {
//     try {
//       await _user.toggleEnabled(
//           ToggleEnabledRequest(userId: userId, enabled: enabled));
//     } catch (e) {
//       Log.e('user/setEnabled: $e.');
//       rethrow;
//     }
//   }
// }
