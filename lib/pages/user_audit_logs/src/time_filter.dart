// part of '../user_audit_logs_page.dart';

// class _TimeFilter extends ConsumerWidget {
//   /// 按照日期范围过滤。
//   const _TimeFilter();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final range = ref.watch(_AuditLogListNotifier.dateRangeProvider);
//     final labelText = range == null
//         ? '选择日期'
//         : (range.start == range.end
//             ? range.start.toDayString()
//             : '${range.start.toDayString()}-${range.end.toDayString()}');

//     return InkWell(
//       onTap: () async => _pickScheduledDay(context, ref, range),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(
//             labelText,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge!
//                 .apply(color: Theme.of(context).colorScheme.secondary),
//           ),
//           SuffixIcon(
//             onRemove: range == null
//                 ? null
//                 : () => ref
//                     .read(_AuditLogListNotifier.dateRangeProvider.notifier)
//                     .update((state) => null),
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> _pickScheduledDay(
//       BuildContext context, WidgetRef ref, DateTimeRange? initialRange) async {
//     final theme = Theme.of(context);
//     final result = await showDateRangePicker(
//       context: context,
//       initialDateRange: initialRange,
//       firstDate: DateTime(0),
//       lastDate: DateTime(9999),
//       currentDate: DateTime.now(),
//       saveText: '确定',
//       locale: const Locale('zh', ''),
//       builder: (context, child) {
//         return Theme(
//           data: theme.copyWith(
//             colorScheme: theme.colorScheme.copyWith(
//               onPrimary: theme.colorScheme.onPrimaryContainer,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (result == null) return;
//     ref
//         .read(_AuditLogListNotifier.dateRangeProvider.notifier)
//         .update((state) => result);
//   }
// }
