import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///可以扫描二维码的输入框
class QRCodeTextfield extends StatelessWidget {
  const QRCodeTextfield({
    super.key,
    this.margin = EdgeInsets.zero,
    required this.controller,
    this.hintText,
    this.labelText,
    this.showQr = true,
    this.prefixIcon,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.textInputAction,
    this.maxLength,
  });

  final EdgeInsetsGeometry margin;
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final bool showQr;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Stack(
        children: [
          TextField(
            onChanged: onChanged,
            controller: controller,
            onSubmitted: onSubmitted,
            onEditingComplete: onEditingComplete,
            textInputAction: textInputAction,
            maxLength: maxLength,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              labelText: labelText,
              hintText: hintText,
              contentPadding: EdgeInsets.only(left: 16.w, right: 48.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          // if (showQr)
          //   Align(
          //     alignment: Alignment.centerRight,
          //     child: IconButton(
          //       icon: const FaIcon(FontAwesomeIcons.qrcode),
          //       onPressed: () => Navigator.of(context)
          //           .pushNamed(Routes.myMobileScanner)
          //           .then((value) {
          //         if (value != null) {
          //           controller.text = value.toString();
          //           onSubmitted?.call(value.toString());
          //         }
          //       }),
          //     ),
          //   )
        ],
      ),
    );
  }
}
