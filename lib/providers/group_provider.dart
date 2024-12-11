// import 'package:capella_app/api/generated/app/group.pb.dart';
// import 'package:capella_app/constant/strings.dart';
// import 'package:capella_app/providers/top_level_providers.dart';
// import 'package:fixnum/fixnum.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final groupListResponseProvider =
//     FutureProvider.autoDispose<GroupListResponse>((ref) async {
//   final groupService = ref.watch(groupServiceProvider);
//   final reponse = await groupService.getGroups();
//   return reponse;
// });

// final selectedGroupProvider =
//     FutureProvider.autoDispose.family<GroupDto, Int64?>((ref, id) {
//   return ref.watch(groupServiceProvider).getGroup(id);
// });

// final currentGroupIdProvider =
//     Provider<Int64>((ref) => throw UnimplementedError());

// final currentGroupProvider = FutureProvider.autoDispose<GroupDto?>((ref) async {
//   final prefs = ref.watch(sharedPreferencesProvider);
//   final spGroupId = prefs.getInt(kCurrentGroupId);
//   var groupId = spGroupId == null ? null : Int64.parseInt(spGroupId.toString());

//   final user = await ref.read(authServiceProvider).getUser();
//   if (groupId == null) {
//     if (user.groups.isEmpty) return null;
//     groupId = user.groups[0].group.id;

//     await ref
//         .read(sharedPreferencesProvider)
//         .setInt(kCurrentGroupId, groupId.toInt());
//   } else {
//     if (user.groups.every((e) => e.group.id != groupId)) {
//       await ref.read(sharedPreferencesProvider).remove(kCurrentGroupId);
//       return null;
//     }
//   }

//   return ref.watch(groupServiceProvider).getGroup(groupId);
// });
