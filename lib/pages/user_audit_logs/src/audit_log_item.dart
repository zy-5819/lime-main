// part of '../user_audit_logs_page.dart';

// class _AuditLogItem extends ConsumerWidget {
//   const _AuditLogItem(this.log);

//   final AuditLogDto log;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       decoration: BoxDecoration(
//           color: cs.onPrimary, borderRadius: BorderRadius.circular(12.r)),
//       child: ListTile(
//         // onTap: () => Navigator.of(context)
//         //     .pushNamed(Routes.userAuditLogDetails, arguments: log),
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//         //操作名称
//         title: Text(
//             log.actionName
//                 .split('/')
//                 .map((e) => e.split('.').toList())
//                 .expand((element) => element)
//                 .skip(3)
//                 .join('/'),
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //操作用户
//             if (log.hasUserName())
//               Row(
//                 children: [
//                   _buildHeader(context, log.userName, Icons.person_2_rounded),
//                   TextButton(
//                     onPressed: () => ref
//                         .read(_AuditLogListNotifier.usernameProvider.notifier)
//                         .update((state) => log.userName),
//                     style: ButtonStyle(
//                         padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
//                             horizontal: 3.w, vertical: 5.h)),
//                         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         minimumSize: const WidgetStatePropertyAll(Size.zero)),
//                     child: Text(
//                       '只看该用户',
//                       style: TextStyle(
//                           fontSize: 12.sp, fontStyle: FontStyle.italic),
//                     ),
//                   )
//                 ],
//               ),

//             //操作时间
//             _buildHeader(
//                 context,
//                 log.timestamp.toDateTime(toLocal: true).formatStringWithMs,
//                 Icons.watch_later_rounded),

//             //请求信息
//             _buildExpandableText(
//                 context, log.requestContent, 'request: ', cs.outline),
//             //响应信息
//             if (log.hasResponseContent())
//               _buildExpandableText(
//                   context, log.responseContent, 'response: ', Colors.green),
//             //错误信息
//             if (log.hasError())
//               _buildExpandableText(context, log.error, 'error: ', cs.error),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context, String title, IconData icon) {
//     final cs = Theme.of(context).colorScheme;
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5.h),
//       child: RichText(
//         text: TextSpan(
//           style: TextStyle(color: cs.outline),
//           children: [
//             WidgetSpan(
//                 child: Padding(
//                     padding: EdgeInsets.only(right: 6.w),
//                     child: Icon(icon, color: cs.outline, size: 16.sp))),
//             TextSpan(text: title),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildExpandableText(
//       BuildContext context, String text, String prefix, Color color) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       // child: ExpandableText(
//       //   text,
//       //   expandText: 'more',
//       //   collapseText: 'less',
//       //   maxLines: 2,
//       //   style: TextStyle(color: color),
//       //   prefixText: prefix,
//       //   linkStyle: TextStyle(
//       //     color: Theme.of(context).colorScheme.primary,
//       //     fontStyle: FontStyle.italic,
//       //   ),
//       //   prefixStyle: TextStyle(
//       //     fontSize: 14.sp,
//       //     fontWeight: FontWeight.bold,
//       //     color: Theme.of(context).colorScheme.outline,
//       //   ),
//       // ),
//     );
//   }
// }
