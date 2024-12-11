// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:lime/widgets/search_bar_tab.dart';
// part 'src/audit_log_list_notifier.dart';
// part 'src/time_filter.dart';
// part 'src/audit_log_list_view.dart';
// part 'src/audit_log_item.dart';

// class UserAuditLogsPage extends ConsumerStatefulWidget {
//   /// 查看用户操作设备的日志。
//   const UserAuditLogsPage({super.key});

//   ///从指定的[BuildContext]中提取参数初始化页面.
//   factory UserAuditLogsPage.route(BuildContext context) =>
//       const UserAuditLogsPage();

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _UserAuditLogsPageState();
// }

// class _UserAuditLogsPageState extends ConsumerState<UserAuditLogsPage> {
//   final _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButton: Padding(
//       //   padding: EdgeInsets.only(bottom: 12.h),
//       //   child: ScrollToTopButton(scrollController: _scrollController),
//       // ),
//       body: RefreshIndicator(
//         edgeOffset: 200.h,
//         onRefresh: () async =>
//             ref.invalidate(_AuditLogListNotifier.auditLogsProvider),
//         child: CustomScrollView(
//           controller: _scrollController,
//           slivers: [_buildAppBar(), _buildBody()],
//         ),
//       ),
//     );
//   }

//   Widget _buildAppBar() {
//     final statusBarHeight = MediaQuery.of(context).viewPadding.top;
//     return SliverAppBar(
//       expandedHeight: 180.h,
//       floating: true,
//       pinned: true,
//       snap: true,
//       title: const Text('操作记录'),
//       centerTitle: true,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Padding(
//           padding: EdgeInsets.only(
//               top: kToolbarHeight + statusBarHeight, left: 20.w, right: 20.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SearchBarTab(
//                 onSubmit: (v) => ref
//                     .read(_AuditLogListNotifier.keywordProvider.notifier)
//                     .update((state) => v),
//                 hintText: '搜索操作记录',
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                       onPressed: () => ref
//                           .read(_AuditLogListNotifier.usernameProvider.notifier)
//                           .update((state) => null),
//                       style: const ButtonStyle(
//                           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                           padding: WidgetStatePropertyAll(EdgeInsets.zero),
//                           minimumSize: WidgetStatePropertyAll(Size.zero)),
//                       child: Text(
//                         '全部用户',
//                         style: TextStyle(fontSize: 12.sp),
//                       )),
//                   const _TimeFilter()
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBody() {
//     return SliverPadding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//       sliver: const _AuditLogListView(),
//     );
//   }
// }
