// part of '../user_audit_logs_page.dart';

// class _AuditLogListView extends ConsumerWidget {
//   const _AuditLogListView();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return RiverPagedBuilder<int, AuditLogDto>.autoDispose(
//         provider: _AuditLogListNotifier.auditLogsProvider,
//         pullToRefresh: false,
//         pagedBuilder: (controller, builder) {
//           return PagedSliverList.separated(
//               pagingController: controller,
//               builderDelegate: PagedChildBuilderDelegate<AuditLogDto>(
//                 itemBuilder:
//                     (BuildContext context, AuditLogDto item, int index) =>
//                         _AuditLogItem(item),
//                 noItemsFoundIndicatorBuilder: (context) =>
//                     const EmptyScreen(title: '暂无操作日志', canClick: false),
//                 newPageProgressIndicatorBuilder: (context) =>
//                     const RobotLoadingWidget(),
//                 firstPageProgressIndicatorBuilder: (context) =>
//                     const RobotLoadingWidget(),
//               ),
//               separatorBuilder: (context, index) => SizedBox(height: 10.h));
//         },
//         itemBuilder: (ctx, item, index) => const SizedBox.shrink(),
//         firstPageKey: 1);
//   }
// }
