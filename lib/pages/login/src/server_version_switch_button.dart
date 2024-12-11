part of '../login_page.dart';

class _ServerVersionSwitchButton extends ConsumerWidget {
  const _ServerVersionSwitchButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            final v = version == ServerVersion.official.toString()
                ? ServerVersion.test
                : ServerVersion.official;
            ref
                .read(sharedPreferencesProvider)
                .setString(kServerVersion, v.toString());
            ref.invalidate(sharedPreferencesProvider);
          },
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Text(
              version == ServerVersion.official.toString() ? '正式版' : '测试版',
              style: TextStyle(
                  fontSize: 13.sp,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
        AnimatedCrossFade(
            firstChild: Container(width: double.infinity),
            secondChild: SizedBox(
              width: 500.w,
              // padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: const Column(
                children: [
                  Row(children: [Expanded(child: _WebAddressTextField())]),
                ],
              ),
            ),
            crossFadeState: version == ServerVersion.test.toString()
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250)),
      ],
    );
  }
}
