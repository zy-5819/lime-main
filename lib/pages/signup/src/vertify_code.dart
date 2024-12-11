part of '../signup_page.dart';

class _VertifyCode extends HookConsumerWidget {
  final Color background;
  final FocusNode? focusNode;
  final void Function()? onPressed;
  final TextEditingController? controller;
  final String verifyStr;

  const _VertifyCode({
    required this.background,
    this.focusNode,
    this.onPressed,
    this.controller,
    required this.verifyStr,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // margin: EdgeInsets.symmetric(
      //   horizontal: 24.w,
      //   vertical: 8.h,
      // ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: background,
        // borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: '验证码',
                icon: FaIcon(
                  FontAwesomeIcons.textHeight,
                  size: 18.sp,
                ),
                alignLabelWithHint: true,
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(verifyStr),
          ),
        ],
      ),
    );
  }
}
