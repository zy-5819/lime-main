part of '../signup_page.dart';

class _TheAgreement extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: ref.watch(_isCheckedProvider),
          onChanged: (b) {
            ref.read(_isCheckedProvider.notifier).update((state) => !state);
          },
        ),
        Text.rich(
          TextSpan(
            text: "登录即代表阅读并同意",
            style: TextStyle(fontSize: 12.sp, color: const Color(0xff999999)),
            children: [
              TextSpan(
                text: '《服务协议》',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
