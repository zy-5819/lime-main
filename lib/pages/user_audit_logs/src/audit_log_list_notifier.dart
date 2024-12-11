// part of '../user_audit_logs_page.dart';

// class _AuditLogListNotifier extends PagedNotifier<int, AuditLogDto> {
//   _AuditLogListNotifier(
//     this.ref, {
//     this.keyword,
//     this.dateRange,
//     this.username,
//   }) : super(
//             load: (page, limit) {
//               return ref.read(userServiceProvider).listAuditLogsBy(
//                     timeBegin: dateRange?.start,
//                     timeEnd: dateRange?.end,
//                     keyword: keyword,
//                     page: page,
//                     pageSize: limit,
//                     username: username,
//                   );
//             },
//             nextPageKeyBuilder: NextPageKeyBuilderDefault.mysqlPagination);

//   final Ref ref;
//   final String? keyword;
//   final DateTimeRange? dateRange;
//   final String? username;

//   static final dateRangeProvider =
//       StateProvider.autoDispose<DateTimeRange?>((ref) => null);

//   static final keywordProvider =
//       StateProvider.autoDispose<String?>((ref) => null);

//   static final usernameProvider =
//       StateProvider.autoDispose<String?>((ref) => null);

//   static final auditLogsProvider = StateNotifierProvider.autoDispose<
//       _AuditLogListNotifier, PagedState<int, AuditLogDto>>((ref) {
//     return _AuditLogListNotifier(ref,
//         keyword: ref.watch(keywordProvider),
//         dateRange: ref.watch(dateRangeProvider),
//         username: ref.watch(usernameProvider));
//   });
// }
