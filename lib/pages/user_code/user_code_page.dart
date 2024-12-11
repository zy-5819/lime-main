// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter/services.dart';

// part 'src/user_code_provider.dart';

// class UserCodePage extends ConsumerWidget {
//   ///使用指定的用户码生成的二维码页面
//   const UserCodePage({super.key});

//   ///从指定的[BuildContext]加载路由参数并初始化页面
//   factory UserCodePage.route(BuildContext context) => const UserCodePage();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final prev = ref.watch(_previousUserCodeProvider);
//     final response = ref.watch(_userCodeResponseProvider).valueOrDefault(prev);
//     return Scaffold(
//       appBar: AppBar(title: const Text('我的二维码')),
//       body: Container(
//           padding: EdgeInsets.all(48.r),
//           margin: EdgeInsets.all(24.r),
//           decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.onPrimary,
//               borderRadius: BorderRadius.circular(24.r)),
//           child: response == null // 首次加载显示loading图标
//               ? const Center(child: RobotLoadingWidget())
//               : Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     QrImageView(
//                       data: response.code.code,
//                       dataModuleStyle: QrDataModuleStyle(
//                           color: Theme.of(context).colorScheme.primary),
//                     ),
//                     _buildUserCode(response.code.code),
//                     _RefreshButton(expiry: response.expiry),
//                   ],
//                 )),
//     );
//   }

//   Widget _buildUserCode(String usercode) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(usercode),
//         IconButton(
//           onPressed: () async {
//             await Clipboard.setData(ClipboardData(text: usercode));
//             await Fluttertoast.showToast(msg: '已复制到剪切板');
//           },
//           icon: const Icon(Icons.copy_rounded),
//           style: ButtonStyle(
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               padding: WidgetStateProperty.all(EdgeInsets.zero),
//               minimumSize: WidgetStateProperty.all(Size.zero)),
//         )
//       ],
//     );
//   }
// }

// class _RefreshButton extends StatefulHookConsumerWidget {
//   ///刷新用户码的组件
//   const _RefreshButton({required this.expiry});

//   ///用户码的有效期
//   final Timestamp expiry;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => __RefreshButtonState();
// }

// class __RefreshButtonState extends ConsumerState<_RefreshButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   Timer? timer;

//   void _resetTimer() {
//     timer?.cancel();

//     // 提前10秒刷新
//     final dueTime = widget.expiry
//         .toDateTime()
//         .add(const Duration(seconds: -10))
//         .difference(DateTime.now())
//         .abs();

//     timer = Timer(dueTime, () => _refresh());
//   }

//   @override
//   void initState() {
//     super.initState();
//     _resetTimer();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2000),
//     );
//   }

//   @override
//   void didUpdateWidget(_RefreshButton oldWidget) {
//     _resetTimer();
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isResfreshing = ref.watch(_isResfreshingProvider);
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 5.h),
//       child: GestureDetector(
//         onTap: _refresh,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               isResfreshing ? '正在刷新' : '点击刷新',
//               style: TextStyle(color: cs.primary),
//             ),
//             ThreeArchedCircle(
//               color: cs.primary,
//               size: 15.sp,
//               controller: _controller,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _refresh() async {
//     try {
//       if (_controller.isAnimating) return;
//       ref.read(_isResfreshingProvider.notifier).update((state) => true);
//       unawaited(_controller.repeat());
//       await Future<void>.delayed(const Duration(milliseconds: 1500));
//       ref.invalidate(_userCodeResponseProvider);
//       _controller.stop();
//       _controller.value = 0;
//       ref.read(_isResfreshingProvider.notifier).update((state) => false);
//     } catch (e) {
//       await Fluttertoast.showToast(msg: Em.exception(e));
//       ref.read(_isResfreshingProvider.notifier).update((state) => false);
//     }
//   }
// }
