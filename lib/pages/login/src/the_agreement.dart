part of '../login_page.dart';

class _TheAgreement extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(LoginProvider.agreementChecked);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          shape: const CircleBorder(),
          value: isChecked,
          onChanged: (b) {
            ref
                .read(LoginProvider.agreementChecked.notifier)
                .update((state) => b!);
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
