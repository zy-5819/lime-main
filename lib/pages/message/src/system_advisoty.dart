part of '../message_page.dart';

class _SystemAdvisory extends HookConsumerWidget {
  const _SystemAdvisory();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return const EmptyScreen(
    //   title: '暂无系统公告',
    //   canClick: false,
    // );
    return ListView(
      physics: const RangeMaintainingScrollPhysics(),
      children: [
        _SystemNotificationItem(
          leading: Icons.message,
          color: const Color(0xFFFFD234),
          title: '系统通知',
          subtitle: 'xxxxxxxxxx',
          datetime: DateTime.now(),
          onTap: () => Navigator.of(context)
              .pushNamed(Routes.messageSystemNotifications),
        ),
        _SystemNotificationItem(
          leading: Icons.tips_and_updates_outlined,
          color: const Color(0xff43BFFF),
          title: '版本更新',
          subtitle: 'xxxxxxxxxxxxxxxxxxxxxx',
          datetime: DateTime.now(),
          onTap: () =>
              Navigator.of(context).pushNamed(Routes.messageVersionUpdate),
        ),
      ],
    );
  }
}

class _SystemNotificationItem extends StatelessWidget {
  const _SystemNotificationItem({
    required this.leading,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.datetime,
    this.onTap,
  });

  final IconData leading;
  final Color color;
  final String title;
  final String subtitle;
  final DateTime datetime;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.3)),
            ),
            Text(
              datetime.toFormatString(),
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.3),
                  fontSize: 12.sp),
            ),
          ],
        ),
        horizontalTitleGap: 16.w,
        leading: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(
            leading,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
