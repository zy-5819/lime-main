
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final userResponseProvider = FutureProvider.autoDispose<UserDto>(
//     (ref) => ref.watch(authServiceProvider).getUser());

// final bindableGroupsProvider =
//     Provider.autoDispose<AsyncValue<List<GroupInfoDto>>>((ref) {
//   return ref.watch(userResponseProvider).whenData((value) => value.groups
//       .where((element) => element.role != ProtoMemberRole.MEMBER_ROLE_VISITOR)
//       .toList());
// });

// final userIdProvider = Provider.autoDispose<Int64?>((ref) {
//   return ref.watch(userResponseProvider).value?.id;
// });

// /// 当前用户是否为超级管理员
// final userIsAdminProvider = Provider.autoDispose<bool>((ref) {
//   final role = ref.watch(userResponseProvider).valueOrNull?.role;
//   return role == 'admin';
// });
