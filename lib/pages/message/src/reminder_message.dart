part of '../message_page.dart';

class _ReminderMessage extends HookConsumerWidget {
  const _ReminderMessage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const EmptyScreen(
      title: '暂无提醒消息',
      canClick: false,
    );
  }
}
