import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/providers/register_provider.dart';

class RegisterInfoTextField extends HookConsumerWidget {
  const RegisterInfoTextField({
    Key? key,
    required this.label,
    this.hintText,
    required this.tag,
    this.footer,
    this.inputFormatters,
    this.obscureText = false,
  }) : super(key: key);
  final String label;
  final String? hintText;
  final RegisterTag tag;
  final Widget? footer;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    final pdr = ref.watch(registerTextPdr(tag));
    return Container(
      color: Theme.of(context).colorScheme.onSurface,
      child: Container(
        padding: EdgeInsets.only(left: 15.r, right: 15.r),
        height: 48.h,
        decoration: UnderlineTabIndicator(
          borderSide:
              BorderSide(width: 0.5.r, color: Theme.of(context).focusColor),
          insets: EdgeInsets.zero,
        ),
        child: Row(
          children: [
            Text(label),
            Expanded(
              child: TextField(
                controller: controller,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                inputFormatters: inputFormatters,
                obscureText: obscureText,
                obscuringCharacter: '*',
                onChanged: (s) {
                  ref.read(pdr.notifier).update((state) => s);
                },
              ),
            ),
            if (footer != null) ...[
              footer!,
            ]
          ],
        ),
      ),
    );
  }
}
