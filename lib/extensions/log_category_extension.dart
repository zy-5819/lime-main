// import 'package:capella_app/api/generated/app/robot.pb.dart';
// import 'package:flutter/material.dart';

// extension LogCategoryExtension on ProtoLogCategory {
//   String toText() {
//     switch (this) {
//       case ProtoLogCategory.LOG_CATEGORY_ERROR:
//         return '错误';
//       case ProtoLogCategory.LOG_CATEGORY_INFORMATION:
//         return '信息';
//       case ProtoLogCategory.LOG_CATEGORY_SUCCESS:
//         return '成功';
//       case ProtoLogCategory.LOG_CATEGORY_UNSPECIFIED:
//         return '未知';
//       case ProtoLogCategory.LOG_CATEGORY_WARNING:
//         return '警告';
//     }
//     return '未知';
//   }

//   Color get color {
//     switch (this) {
//       case ProtoLogCategory.LOG_CATEGORY_ERROR:
//         return Colors.red;
//       case ProtoLogCategory.LOG_CATEGORY_INFORMATION:
//         return Colors.grey;
//       case ProtoLogCategory.LOG_CATEGORY_SUCCESS:
//         return Colors.green;
//       case ProtoLogCategory.LOG_CATEGORY_UNSPECIFIED:
//         return Colors.grey;
//       case ProtoLogCategory.LOG_CATEGORY_WARNING:
//         return Colors.orange;
//     }
//     return Colors.grey;
//   }

//   /// 作业日志图标。
//   IconData toIconData() {
//     switch (this) {
//       case ProtoLogCategory.LOG_CATEGORY_ERROR:
//         return Icons.error_outline_rounded;
//       case ProtoLogCategory.LOG_CATEGORY_INFORMATION:
//         return Icons.info_outline_rounded;
//       case ProtoLogCategory.LOG_CATEGORY_SUCCESS:
//         return Icons.done_rounded;
//       case ProtoLogCategory.LOG_CATEGORY_UNSPECIFIED:
//         return Icons.question_mark_rounded;
//       case ProtoLogCategory.LOG_CATEGORY_WARNING:
//         return Icons.warning_amber_rounded;
//     }
//     return Icons.question_mark_rounded;
//   }

//   /// 运行日志图标。
//   IconData get iconData {
//     switch (this) {
//       case ProtoLogCategory.LOG_CATEGORY_ERROR:
//         return Icons.error_rounded;
//       case ProtoLogCategory.LOG_CATEGORY_INFORMATION:
//         return Icons.info_rounded;
//       case ProtoLogCategory.LOG_CATEGORY_SUCCESS:
//         return Icons.check_circle_rounded;
//       case ProtoLogCategory.LOG_CATEGORY_UNSPECIFIED:
//         throw UnimplementedError();
//       case ProtoLogCategory.LOG_CATEGORY_WARNING:
//         return Icons.warning_rounded;
//     }

//     throw UnimplementedError();
//   }
// }
