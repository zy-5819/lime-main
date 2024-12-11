// import 'package:capella_app/api/generated/models.pb.dart';
// import 'package:capella_app/extensions/datetime_extension.dart';
// import 'package:capella_app/nav/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:json_text_field/json_text_field.dart';

// class UserAuditLogDetailsPage extends StatefulWidget {
//   /// 操作记录详情页面。
//   const UserAuditLogDetailsPage({super.key, required this.log});

//   final AuditLogDto log;

//   ///从指定的[BuildContext]中提取参数初始化页面.
//   factory UserAuditLogDetailsPage.route(BuildContext context) =>
//       UserAuditLogDetailsPage(log: context.args<AuditLogDto>());

//   @override
//   State<UserAuditLogDetailsPage> createState() =>
//       _UserAuditLogDetailsPageState();
// }

// class _UserAuditLogDetailsPageState extends State<UserAuditLogDetailsPage> {
//   late AuditLogDto log;
//   final requestController = JsonTextFieldController();
//   final responseJsonController = JsonTextFieldController();
//   final errorJsonController = JsonTextFieldController();

//   @override
//   void initState() {
//     super.initState();
//     log = widget.log;
//     requestController.text = log.requestContent;
//     if (log.hasResponseContent()) {
//       responseJsonController.text = log.responseContent;
//     }
//     if (log.hasError()) {
//       errorJsonController.text = log.error;
//     }
//   }

//   @override
//   void dispose() {
//     responseJsonController.dispose();
//     requestController.dispose();
//     errorJsonController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('操作详情'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//         shrinkWrap: true,
//         physics: const RangeMaintainingScrollPhysics(),
//         children: [
//           Text(
//               log.actionName
//                   .split('/')
//                   .map((e) => e.split('.').toList())
//                   .expand((element) => element)
//                   .skip(3)
//                   .join('/'),
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
//           //操作用户
//           if (log.hasUserName())
//             _buildHeader(context, log.userName, Icons.person_2_rounded),

//           //操作时间
//           _buildHeader(
//               context,
//               log.timestamp.toDateTime(toLocal: true).formatStringWithMs,
//               Icons.watch_later_rounded),

//           SizedBox(height: 6.h),
//           Text(
//             'request',
//             style: TextStyle(fontWeight: FontWeight.bold, color: cs.primary),
//           ),
//           _buildContainer(context, _buildField(context, requestController)),
//           SizedBox(height: 6.h),
//           if (log.hasResponseContent())
//             Text(
//               'response',
//               style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold),
//             ),
//           if (log.hasResponseContent())
//             _buildContainer(
//                 context, _buildField(context, responseJsonController)),
//           SizedBox(height: 6.h),
//           if (log.hasError())
//             Text(
//               'error',
//               style: TextStyle(color: cs.error, fontWeight: FontWeight.bold),
//             ),
//           if (log.hasError())
//             _buildContainer(
//                 context,
//                 Text(log.error,
//                     style: TextStyle(
//                       color: cs.error,
//                       fontSize: 13.sp,
//                     )),
//                 padding:
//                     EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h)),
//         ],
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

//   Widget _buildField(BuildContext context, JsonTextFieldController controller) {
//     final cs = Theme.of(context).colorScheme;
//     return JsonTextField(
//       boolHighlightStyle: TextStyle(color: cs.primary),
//       numberHighlightStyle: TextStyle(color: cs.primary),
//       stringHighlightStyle: TextStyle(color: cs.secondary),
//       keyHighlightStyle: TextStyle(
//           color: cs.primary.withOpacity(0.7), fontWeight: FontWeight.bold),
//       decoration: const InputDecoration(border: InputBorder.none),
//       readOnly: true,
//       maxLines: null,
//       controller: controller,
//     );
//   }

//   Widget _buildContainer(BuildContext context, Widget child,
//       {EdgeInsetsGeometry? padding}) {
//     return Container(
//       padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.onPrimary,
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: child,
//     );
//   }
// }
