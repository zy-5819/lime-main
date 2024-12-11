part of '../signup_page.dart';

class _ItemWidget extends HookConsumerWidget {
  final Color background;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final void Function()? onEditingComplete;
  final String hintText;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? icon;
  final FocusNode? focusNode;
  final String? errorText;
  final bool? obscureText;

  const _ItemWidget({
    required this.background,
    this.controller,
    this.onChanged,
    this.validator,
    this.onEditingComplete,
    required this.hintText,
    this.suffixText,
    this.inputFormatters,
    this.icon,
    this.focusNode,
    this.errorText,
    this.obscureText,
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
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          suffixText: suffixText,
          errorText: errorText,
          suffixStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w100,
          ),
          icon: icon,
          alignLabelWithHint: true,
          border: InputBorder.none,
          errorStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w100,
          ),
        ),
        textInputAction: TextInputAction.next,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        validator: validator,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
