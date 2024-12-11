part of '../message_system_notifications_page.dart';

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          children: [
            Text(
              DateTime.now().toFormatString(),
              style: TextStyle(
                  fontSize: 13.sp, color: cs.onSurfaceVariant.withOpacity(0.3)),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.onPrimary,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '以旧换新限时开启!',
                        style: TextStyle(color: cs.primary),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        '以旧换新，限时开启。辞旧迎新，兔个吉利！',
                        style: TextStyle(
                            color: cs.onSurfaceVariant.withOpacity(0.5)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
