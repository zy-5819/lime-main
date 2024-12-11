// part of '../user_code_page.dart';

// import 'package:hooks_riverpod/hooks_riverpod.dart';

// ///存储获取的当前用户的用户码[UserCodeResponse]
// final _userCodeResponseProvider =
//     FutureProvider.autoDispose<UserCodeResponse?>((ref) async {
//   final code = await ref.watch(authServiceProvider).userCode();
//   ref.read(_previousUserCodeProvider.notifier).update((state) => code);
//   return code;
// });

// ///存储上一次获取到的当前用户的用户码[UserCodeResponse]
// final _previousUserCodeProvider =
//     StateProvider.autoDispose<UserCodeResponse?>((ref) => null);

// final _isResfreshingProvider = StateProvider.autoDispose<bool>((ref) => false);
